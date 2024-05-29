import express from "express";
import authController from "../../controllers/AuthController";

const router = express.Router();

router.post("/login", authController.onLoginUser);
router.post("/sign_up",authController.onRegisterUser);

export default router;