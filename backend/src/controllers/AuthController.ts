import { Request, Response } from "express";
import bcrypt from "bcrypt";
import User from "../models/user";
import { session } from "../middleware/session";

const onRegisterUser = async (req: Request, res: Response) => {
  const { first_name, last_name, phone, password, email, age } = req.body;

  if (!first_name || !last_name || !password || !email || !phone || !age)
    return res.status(400).json({ message: "Fields are required." });

  const duplicate = await User.findOne({ email });
  if (duplicate) return res.sendStatus(409);
  try {
    const hashedPwd = await bcrypt.hash(password, 10);
    const newUser = new User({
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: hashedPwd,
      phone: phone,
      age: age,
    });
    await newUser.save();
    session.setSessionUser({ email, password });

    res.status(201).json(newUser);
  } catch (error) {
    res.status(500).json({ message: error });
  }
};

const onLoginUser = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  console.log();
  if (!password || !email)
    return res
      .status(400)
      .json({ message: "Password and email are required." });
  const foundUser = await User.findOne({ email: email });
  console.log(foundUser);
  if (!foundUser) return res.sendStatus(401);

  const match = await bcrypt.compare(password, foundUser.password);

  if (!match) res.sendStatus(401);
  session.setSessionUser({ email, password });

  res.status(200).json(foundUser);
};

export default {
  onRegisterUser,
  onLoginUser,
};
