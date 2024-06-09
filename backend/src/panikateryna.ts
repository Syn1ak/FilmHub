import Session from "./models/session";
import Movie from "./models/movie";
import Hall from "./models/hall";
import User from "./models/user";

const prices = [143, 190, 113, 178, 198, 156, 200, 210, 145, 185];
const seatsNumbers = [9, 10, 12];
const dates: Array<string> = [];
const today = new Date();

for (let i = 0; i < 7; i++) {
  const nextDate = new Date(today);
  nextDate.setDate(today.getDate() + i);
  dates.push(nextDate.toISOString().split('T')[0]);
}

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
const fillSessions = async () => {
  const movies = await Movie.find({ releaseDate: { $lt: new Date() } });
  const halls = await Hall.find();
  for (const hall of halls) {
    const movie = movies[getRandomInt(movies.length)];
    for (const date of dates) {
      const sessions = [];
      const startTimes = [
        "09:00:00",
        "11:00:00",
        "13:00:00",
        "15:00:00",
        "17:00:00",
        "19:00:00",
      ];
      const endTimes = [
        "11:00:00",
        "13:00:00",
        "15:00:00",
        "17:00:00",
        "19:00:00",
        "21:00:00",
      ];

      for (let i = 0; i < startTimes.length; i++) {
        const s = new Session({
          movie: movie._id,
          hall: hall._id,
          price: prices[getRandomInt(prices.length)],
          seats: getSeats(seatsNumbers[getRandomInt(seatsNumbers.length)]),
          start_time: new Date(`${date}T${startTimes[i]}`),
          end_time: new Date(`${date}T${endTimes[i]}`),
        });
        sessions.push(s);
      }
      await Session.insertMany(sessions);
    }
  }
}

export async function initialSetUp() {
  await User.find();
  fillSessions().then(() => console.log("Filled sesssions"));
  setInterval(() => fillSessions(), 604800000);
}