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
    release_year:{
        type: Date,
        required: true,
    },
    language:{
        type: String,
        required: true,
    },
    duration:{
        type: String,
    },
    poster:{
        type: String
    },
    director:{
        type:String
    },
    rating:{
        type: Number, min: 1, max: 10
    }
})
const Movie = mongoose.model("Movie", movieSchema);
export default Movie;