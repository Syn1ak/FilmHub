import {Request, Response} from "express";
import Session from "../models/session";

const getSessionByMovieAndDate = async (req: Request, res: Response) => {
    const {movie_id, cinema_id, date} = req.query;
    if (!movie_id || !cinema_id || !date) {
        return res.status(401).json({message: "Cannot find some required field!"});
    }

    try {
        const dateString = Array.isArray(date) ? date[0] : date;

        if (typeof dateString !== 'string') {
            return res.status(400).json({message: "Invalid date format"});
        }
        const today = new Date();
        today.setHours(today.getHours() -9);
        console.log("T", today);

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

        const sessions = sessionByMovieAndDate.filter((item) => {
            if (item.hall != null && item.start_time > today)
                return item;
        });
        console.log(sessions.length)
        res.json(sessions);
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
};

export default {
    getSessionByMovieAndDate,
};
