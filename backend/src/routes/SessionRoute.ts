import express from "express";
import SessionController from  "../controllers/SessionController";
const router = express.Router();
router.get("/getSessionByMovieAndDate", SessionController.getSessionByMovieAndDate);
export default router;