import express, { Request, Response } from "express";
import cors from "cors";
import "dotenv/config";

const PORT = process.env.PORT || 7010;

const app = express();
app.use(express.json());
app.use(cors());

app.get("/test", async (req: Request, res: Response) => {
  res.json({ message: "Hello" });
});

app.listen(PORT, () => {
  console.log(`Server started on localhost:${PORT}`);
});
