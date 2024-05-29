import {Request, Response} from "express";
import Session from "../models/session";

const getAllSessionByMovie = async (req: Request, res: Response) => {
    try {
        const {movie_id} = req.query;
        console.log(movie_id);

        const allSessions = await Session.find();
        console.log(allSessions);

        res.json(allSessions)
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
}

export default {getAllSessionByMovie};