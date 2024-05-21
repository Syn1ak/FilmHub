import { Request, Response } from "express";
import Genre from "../models/genre";

const getAllGenres = async (req: Request, res: Response) => {
    try {
        const allGenres = await Genre.find();
        res.json(allGenres);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

export default {
    getAllGenres,
};
