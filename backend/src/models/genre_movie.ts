import mongoose from "mongoose";

const genreMovieSchema = new mongoose.Schema({
    genre: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Genre",
    },
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
    },

})
const GenreMovie = mongoose.model("GenreMovie", genreMovieSchema);
export default GenreMovie;