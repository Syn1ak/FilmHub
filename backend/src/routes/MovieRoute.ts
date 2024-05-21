import express from "express";
import MovieController from "../controllers/MovieController";

const router = express.Router();

router.get("/", MovieController.getListOfMovies);
router.get("/movie", MovieController.getMovieById);
router.get("/future_movie", MovieController.getFuturePremiere);
router.post("/movie/add_review", MovieController.addReviewToMovie);

export default router;