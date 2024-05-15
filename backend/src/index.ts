import express, { Request, Response } from "express";
import cors from "cors";
import "dotenv/config";
import mongoose from "mongoose";
import User from "./models/film";

const PORT = process.env.PORT || 7010;

console.log(process.env.MONGODB_CONNECTION_STRING);

mongoose
  .connect(process.env.MONGODB_CONNECTION_STRING as string)
  .then(() => console.log("Connected to database!"));

  getUsers();
async function getUsers() {
  try {
    const users = await User.find();
    console.log("Users", users);
  } catch (e) {
    console.log(e);
  }
}
// addUser();
async function addUser() {
  try {
    const user = new User({
      email: "lyashko@gmail.com",
      firstname: "Kyle",
      lastname: "Lyashka",
      age: 26,
    });
    await user.save();
    console.log("Users", user);
  } catch (e) {
    console.log(e);
  }
}

const app = express();
app.use(express.json());
app.use(cors());

app.get("/test", async (req: Request, res: Response) => {
  res.json({ message: "Hello" });
});

app.listen(PORT, () => {
  console.log(`Server started on localhost:${PORT}`);
});
