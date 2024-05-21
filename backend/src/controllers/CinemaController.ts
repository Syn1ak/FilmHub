import {Request, Response} from "express";
import Cinema from "../models/cinema";

const getAllCinemasByCity = async (req: Request, res:Response) => {
    try {
        const {city_id} = req.query;
        const allCinemasByCity = await Cinema.find({city_id});
        res.json(allCinemasByCity);
    } catch (er) {
        console.log(er);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

export default {
    getAllCinemasByCity
}