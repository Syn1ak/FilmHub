import express from "express";
import MovieController from "../controllers/MovieController";

const router = express.Router();

router.get("/", MovieController.getListOfMovies);

export default router;