import express, { Request, Response } from "express";
import cors from "cors";
import "dotenv/config";
import mongoose from "mongoose";

import movieRouter from './routes/MovieRoute';
import movieRoute from "./routes/MovieRoute";

const PORT = process.env.PORT || 7010;

mongoose
  .connect(process.env.MONGODB_CONNECTION_STRING as string)
  .then(() => console.log("Connected to database!"));


// addActor();
// async function addActor(){
//   try {
//     const actor = new ActorMovie({
//       movie:"664672c4cf84d0736ecdf072",
//       actor: "66466decb9279ea92a3049e0",
//     });
//     const savedActor = await actor.save();
//     console.log("Actor", savedActor);
//   } catch (e) {
//     console.log(e);
//   }
// }

// getActors();
// async function getActors() {
//   await Actor.find();
// }
//
// getMovie();
// async function getMovie() {
//   const movie = await Movie.find({ _id: "664672c4cf84d0736ecdf06b" });
//   const actorsByMovie = await ActorMovie.find({ movie: "664672c4cf84d0736ecdf072" }).populate("actor");
//
//   console.log(movie);
//   console.log(actorsByMovie);
// }


const app = express();
app.use(express.json());
app.use(cors());

app.use('/api/movies', movieRoute);

app.get("/test", async (req: Request, res: Response) => {
  res.json({ message: "Hello" });
});

app.listen(PORT, () => {
  console.log(`Server started on localhost:${PORT}`);
});
