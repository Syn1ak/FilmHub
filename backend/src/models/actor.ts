import mongoose from "mongoose";

const actorSchema = new mongoose.Schema({
    first_name:{
        type: String,
        required: true,
    },
    last_name:{
        type: String,
        required: true,
    },
    photo:{
        type: String,
        required: true,
    }

})
const Actor = mongoose.model("Actor", actorSchema);
export default Actor;