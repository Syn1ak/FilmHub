import express from "express";
import SessionController from  "../controllers/SessionController";
const router = express.Router();
// app.use("/session", ...)
router.get("/getAllSessionByMovie", SessionController.getAllSessionByMovie);

export default router;