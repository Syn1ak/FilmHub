import mongoose from "mongoose";

const actorSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    popular_movies:{
        type: [String],
        required: true,
    }
})
const Actor = mongoose.model("Actor", actorSchema);
export default Actor;