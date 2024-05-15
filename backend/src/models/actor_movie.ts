import mongoose from "mongoose";

const actorMovieSchema = new mongoose.Schema({
    actor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Actor",
    },
    movie: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
    },

})
const ActorMovie = mongoose.model("ActorMovie", actorMovieSchema);
export default ActorMovie;