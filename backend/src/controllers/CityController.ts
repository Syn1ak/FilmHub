import { Request, Response } from "express";
import City from "../models/city";

const getAllCities = async (req: Request, res: Response) => {
  try {
    const allCities = await City.find();
    res.json(allCities);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

export default {
  getAllCities,
};
