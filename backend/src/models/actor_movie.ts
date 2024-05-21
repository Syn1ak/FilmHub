import mongoose from "mongoose";

const actorMovieSchema = new mongoose.Schema({
    actor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Actor",
        required: true,
    },
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
        required: true,
    },

})
const ActorMovie = mongoose.model("ActorMovie", actorMovieSchema);
export default ActorMovie;