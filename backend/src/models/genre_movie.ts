import mongoose from "mongoose";

const genreMovieSchema = new mongoose.Schema({
    genre: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Genre",
        required: true,
    },
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
        required: true,
    },

})
const GenreMovie = mongoose.model("GenreMovie", genreMovieSchema);
export default GenreMovie;