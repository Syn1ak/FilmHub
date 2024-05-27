import mongoose from "mongoose";

const movieSchema = new mongoose.Schema({
    title:{
        type: String,
        required: true,
    },
    description:{
        type: String,
        required: true,
    },
    releaseDate:{
        type: Date,
        required: true,
    },
    language:{
        type: String,
        required: true,
    },
    duration:{
        type: Number,
    },
    thumbnail:{
        type: String
    },
    director:{
        type:String
    },
    rating: {
        type: Number, min: 0, max: 5
    },
    trailer: {
        type: String
    },
    age_limit: {
        type: Number,
        required: true
    }
})
const Movie = mongoose.model("Movie", movieSchema);
export default Movie;