import mongoose from "mongoose";

const cinemaSchema = new mongoose.Schema({
    city_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "City",
    },
    name:{
        type: String,
        required: true,
    },
    address:{
        type: String,
        required: true,
    }
})
const Cinema = mongoose.model("Cinema", cinemaSchema);
export default Cinema;