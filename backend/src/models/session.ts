import mongoose from "mongoose";

const sessionSchema = new mongoose.Schema({
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
        required: true,
    },
    hall:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Hall",
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    seats: {
        type: [[Boolean]],
        required: true
    },
    start_time: {
        type: Date,
        required: true,
    },
    end_time:{
        type: Date,
        required: true
    }
})
const Session = mongoose.model("Session", sessionSchema);
export default Session;