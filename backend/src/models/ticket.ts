import mongoose, {now} from "mongoose";

const ticketSchema = new mongoose.Schema({
    session: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Session",
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    },
    seat_number:{
        type: Number,
        required: true
    },
    purchase_date:{
        type: Date,
        default: Date.now(),
        required: true
    },
    // TODO: price??


})
const Ticket = mongoose.model("Ticket", ticketSchema);
export default Ticket;