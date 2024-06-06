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
import { sessionCheck } from "./middleware/session";
import Movie from "./models/movie";
import Session from "./models/session";

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

app.use(sessionCheck);

app.use("/api/movies", movieRoute);
app.use("/api/cities", cityRoute);
app.use("/api/genres", genreRoute);
app.use("/api/cinemas", cinemaRoute);
app.use("/api/user", userRoute);
app.use("/api/sessions", sessionRoute);

app.get("/test", async (req: Request, res: Response) => {
  const allHalls = await Hall.find({ cinema_id: req.query.id });

  console.log(allHalls.length);
  res.json(allHalls);
});

const prices = [143, 190, 113, 178, 198, 156, 200, 210, 145, 185];
const seatsNumbers = [9, 10, 12];
const dates = [
  "2024-06-06",
  "2024-06-07",
  "2024-06-08",
  "2024-06-09",
  "2024-06-10",
  "2024-06-11",
  "2024-06-12",
  "2024-06-13",
  "2024-06-14",
  "2024-06-15",
  "2024-06-16",
  "2024-06-17",
  "2024-06-18",
  "2024-06-19",
  "2024-06-20",
];

function getRandomInt(max: number) {
  return Math.floor(Math.random() * max);
}

function getSeats(size: number) {
  const result = [...Array(size)].fill(new Array(10));
  for (let i = 0; i < size; i++) {
    for (let j = 0; j < 10; j++) {
      result[i][j] = false;
    }
  }
  return result;
}

app.get("/fillSessions", async (req: Request, res: Response) => {
  const movies = await Movie.find({ releaseDate: { $lt: new Date() } });
  const halls = await Hall.find();

  for (const hall of halls) {
    for (const movie of movies) {
      for (const date of dates) {
        const s1 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T09:00:00`),
          end_time: new Date(`${date}T11:00:00`),
        });
        await s1.save();
        const s2 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T11:00:00`),
          end_time: new Date(`${date}T13:00:00`),
        });
        await s2.save();
        const s3 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T13:00:00`),
          end_time: new Date(`${date}T15:00:00`),
        });
        await s3.save();
        const s4 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T15:00:00`),
          end_time: new Date(`${date}T17:00:00`),
        });
        await s4.save();
        const s5 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T17:00:00`),
          end_time: new Date(`${date}T19:00:00`),
        });
        await s5.save();
        const s6 = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(10)],
          seats: getSeats(seatsNumbers[getRandomInt(3)]),
          start_time: new Date(`${date}T19:00:00`),
          end_time: new Date(`${date}T21:00:00`),
        });
        await s6.save();
      }
    }
  }

  res.sendStatus(200);
});

app.listen(PORT, () => {
  console.log(`Server started on localhost:${PORT}`);
});
