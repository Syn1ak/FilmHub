import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    first_name: {
        type: String,
        required: true
    },
    last_name: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    email:{
        type: String,
        required: true
    },
    age:{
        type: Number,
        min: 0, max:130,
        required: true
    },
    phone:{
        type:String,
        required: true
    }
})
const User = mongoose.model("User", userSchema);
export default User;