import express from "express";
import UserController from "../controllers/UserController";

const router = express.Router();

router.get("/profile", UserController.getUserById);
router.get("/tickets", UserController.getAllUserTickets);
router.post("/add_ticket", UserController.addTicket);
router.put("/", UserController.onUpdateUser);

export default router;