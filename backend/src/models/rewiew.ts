import mongoose from "mongoose";
import moment from "moment-timezone";

const reviewSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Movie'
    },
    rating:{
        type: Number, min:0, max:5,
    },
    comment:{
        type: String,
        required: true
    },
    review_date:{
        type: Date,
        required: true
    }
})
const Review = mongoose.model("Review", reviewSchema);
export default Review;