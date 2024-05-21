import express from "express";
import GenreController from "../controllers/GenreController";

const router = express.Router();

router.get("/", GenreController.getAllGenres);

export default router;
