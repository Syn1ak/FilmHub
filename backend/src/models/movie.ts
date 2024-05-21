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
        type: String,
    },
    thumbnail:{
        type: String
    },
    director:{
        type:String
    },
    rating:{
        type: Number, min: 0, max: 5
    }
})
const Movie = mongoose.model("Movie", movieSchema);
export default Movie;