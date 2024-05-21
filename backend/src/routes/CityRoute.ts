import express from "express";
import CityController from "../controllers/CityController";

const router = express.Router();

router.get("/", CityController.getAllCities);

export default router;
