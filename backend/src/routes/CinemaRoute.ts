import express from "express";
import CinemaController from "../controllers/CinemaController";

const router = express.Router();
router.get("/", CinemaController.getAllCinemasByCity);

export default router;
