import mongoose from "mongoose";

const hallSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  cinema_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Cinema",
  },
});
const Hall = mongoose.model("Hall", hallSchema);
export default Hall;
