import { Request, Response } from "express";
import Session from "../models/session";

const getAllSessionByMovie = async (req: Request, res: Response) => {
  try {
    const { movie_id } = req.query;
    const allSessions = await Session.find({ movie: movie_id })
      .populate({
        path: "hall",
        populate: {
          path: "cinema_id",
        },
      })
      .populate("movie");

    res.json(allSessions);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

const getSessionByMovieAndDate = async (req: Request, res: Response) => {
  const { movie_id, cinema_id, date } = req.query;

  try {
    //{ $expr: {$eq: ["2021-03-29", { $dateToString: {date: "$dateField", format: "%Y-%m-%d"}}]}}
    const sessionByMovieAndDate = await Session.find({
      movie: movie_id,
      $expr: {
        $eq: [
          date,
          {
            $dateToString: { date: "$start_time", format: "%Y-%m-%d" },
          },
        ],
      },
    }).populate({
      path: "hall",
      match: { cinema_id: cinema_id },
    });

    const sessions = sessionByMovieAndDate.filter((item) => item.hall != null);

    res.json(sessions);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

export default {
  getSessionByMovieAndDate,
  getAllSessionByMovie,
};
