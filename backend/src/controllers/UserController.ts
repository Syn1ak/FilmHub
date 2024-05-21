import {Request, Response} from "express";
import User from "../models/user";
import Ticket from "../models/ticket";
import mongoose from "mongoose";

const getUserById = async (req: Request, res: Response) => {
    try {
        const { id } = req.query;

        const user = await User.findOne({ _id: id });

        if(!user) return res.status(401).json({ message: "User not found with that ID!"})

        res.json(user)
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
}

const getAllUserTickets = async (req: Request, res: Response) => {
    try {
        const {user} = req.query;

        const allTickets = await Ticket.find({ user });

        res.json(allTickets);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
}

const addTicket = async (req: Request, res: Response) => {
    try{
        const {session_id, user_id, seat_row, seat_number} =  req.query;

        const newTicket = new Ticket({
            session: new mongoose.Types.ObjectId(session_id as string),
            user:  new mongoose.Types.ObjectId(user_id as string),
            seat_row: seat_row,
            seat_number: seat_number
        })
        await newTicket.save();

        return res.status(201).json(newTicket);
    } catch (error){
        console.log(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
}

export default {
    getUserById,
    getAllUserTickets,
    addTicket
}

