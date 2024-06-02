import express, { Request, Response } from "express";
import cors from "cors";
import "dotenv/config";
import mongoose from "mongoose";

import movieRoute from "./routes/MovieRoute";
import cityRoute from "./routes/CityRoute";
import genreRoute from "./routes/GenreRoute";
import cinemaRoute from "./routes/CinemaRoute";
import User from "./models/user";
import userRoute from "./routes/UserRoute";
import sessionRoute from "./routes/SessionRoute";
import Hall from "./models/hall";
import authRoute from "./routes/auth/AuthRoute";
import {webcrypto} from "crypto";

const PORT = process.env.PORT || 7010;

mongoose
  .connect(process.env.MONGODB_CONNECTION_STRING as string)
  .then(() => console.log("Connected to database!"));


getActors();
async function getActors() {
  await User.find();
}


const app = express();
app.use(express.json());
app.use(cors());

app.use("/api/auth", authRoute);
app.use("/api/movies", movieRoute);
app.use("/api/cities", cityRoute);
app.use("/api/genres", genreRoute);
app.use("/api/cinemas", cinemaRoute);
app.use("/api/user", userRoute);
app.use("/api/sessions", sessionRoute)

app.get("/test", async (req: Request, res: Response) => {
  const allHalls = await Hall.find({ cinema_id: req.query.id });

  console.log(allHalls.length);
  res.json(allHalls);
});

app.listen(PORT, () => {
  console.log(`Server started on localhost:${PORT}`);
});
