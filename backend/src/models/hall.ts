import mongoose from "mongoose";

const hallSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true,
    },
    // seats in map
    number_of_available_seats:{
        type: Number,
        required: true,
    },

})
const Hall = mongoose.model("Hall", hallSchema);
export default Hall;