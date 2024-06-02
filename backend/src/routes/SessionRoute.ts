import express from "express";
import SessionController from  "../controllers/SessionController";
const router = express.Router();
// app.use("/session", ...)
router.get("/getAllSessionByMovie", SessionController.getAllSessionByMovie);
router.get("/getSessionByMovieAndDate", SessionController.getSessionByMovieAndDate);
export default router;