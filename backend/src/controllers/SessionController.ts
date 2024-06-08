import { Request, Response } from "express";
import Session from "../models/session";

const getSessionByMovieAndDate = async (req: Request, res: Response) => {
  const { movie_id, cinema_id, date } = req.query;
  if( !movie_id || !cinema_id || !date ){
    return res.status(401).json({message: "Cannot find some required field!"});
  }

  try {
    const dateString = Array.isArray(date) ? date[0] : date;

    if (typeof dateString !== 'string') {
      return res.status(400).json({ message: "Invalid date format" });
    }
    const convertedDate = new Date(dateString);
    const today = new Date();
    console.log(today);
    console.log(convertedDate)
    console.log(date)
    if(convertedDate < today)
    return res.status(200).json([]);
    else {
      const sessionByMovieAndDate = await Session.find({
        movie: movie_id,
        $expr: {
          $eq: [
            date,
            {
              $dateToString: {date: "$start_time", format: "%Y-%m-%d"},
            },
          ],
        },
      }).populate([
        {
          path: "hall",
          match: {cinema_id: cinema_id},
          populate: {
            path: "cinema_id",
            populate: {
              path: "city_id",
            },
          },
        },
        {
          path: "movie",
        },
      ]);

      const sessions = sessionByMovieAndDate.filter((item) => item.hall != null);
      console.log(sessions.length)
      res.json(sessions);
    }
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

export default {
  getSessionByMovieAndDate,
};
