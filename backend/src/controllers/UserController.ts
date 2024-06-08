import {Request, Response} from "express";
import User from "../models/user";
import Ticket from "../models/ticket";
import mongoose from "mongoose";
import Session from "../models/session";

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
        const {user_id} = req.query;

        const allTickets = await Ticket.find({ user: user_id })
            .populate("user")
            .populate({
                path: "session",
                populate: [
                    {
                        path: "hall",
                        populate: {
                            path: "cinema_id",
                            populate: {
                                path: "city_id",
                            },
                        },
                    },
                    {
                        path: "movie",
                    },
                ],
            });
        res.json(allTickets);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
}

const addTicket = async (req: Request, res: Response) => {
    try{
        const {session_id, user_id, seat_row, seat_number} =  req.body;

        const newTicket = new Ticket({
            session: new mongoose.Types.ObjectId(session_id as string),
            user:  new mongoose.Types.ObjectId(user_id as string),
            seat_row: seat_row,
            seat_number: seat_number
        })
        await newTicket.save();
        await Session.updateOne({_id: session_id},
            {$set: { [`seats.${seat_row}.${seat_number}`] : true }});
        return res.status(201).json(newTicket);
    } catch (error){
        console.log(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

const onUpdateUser = async (req: Request, res: Response) => {
    const {
        _id,
        first_name,
        last_name,
        phone,
        email,
        age
    } = req.body;

    if (!_id || !first_name || !last_name || !email || !phone || !age)
        return res
            .status(400)
            .json({message: "Fields are required."});

    const foundUser = await User.findOne({ _id });

    if(!foundUser) res.status(401).json({ message: "User not found" });
    else {
        foundUser.first_name = first_name;
        foundUser.last_name = last_name;
        foundUser.phone = phone;
        foundUser.email = email;
        foundUser.age = age as number;
        await foundUser.save();
    }
    res.status(200).json(foundUser);
}

export default {
    getUserById,
    getAllUserTickets,
    addTicket,
    onUpdateUser
}

