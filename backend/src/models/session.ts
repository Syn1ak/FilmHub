import mongoose from "mongoose";

const sessionSchema = new mongoose.Schema({
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
    },
    hall:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Hall",
    },
    seats: {
        type: [[Number]],
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