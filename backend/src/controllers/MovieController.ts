import {Request, Response} from "express";
import Movie from "../models/movie";
import mongoose from "mongoose";
import Actor from "../models/actor";
import GenreMovie from "../models/genre_movie";
import ActorMovie from "../models/actor_movie";
import Session from "../models/session";
import Cinema from "../models/cinema";
import Hall from "../models/hall";

const getListOfMovies = async (req: Request, res: Response) => {
    try {
        const { cinema, city, genres, date, actor, query } = req.query;

        console.log(cinema, city, genres, date, actor, query);

        let moviesIds = new Set<string>();

        if (city) {
            const cinemas = await Cinema.find({city_id: city});
            let cinemasIds = cinemas.map(item => item._id);
            if (cinema) {
                cinemasIds = cinemasIds
                    .filter(id => id.toString() === cinema);
            }

            console.log(cinemasIds)
            const halls = await Hall.find({
                cinema_id: {$in: cinemasIds}
            })
            const hallsIds = halls.map(item => item._id);
            const sessions = await Session.find({
                hall: {$in: hallsIds}
            });
            const ids = sessions.map(item => item.movie.toString());
            moviesIds = new Set<string>([...ids]);
            console.log("moviesIds", moviesIds)
        }

        if(genres) {
            const moviesIdsWithGenre = await GenreMovie.find({ genre: { $in: genres }});
            const ids = moviesIdsWithGenre.map(item => item.movie.toString());
            moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithGenre", moviesIds)
        }

        if(date) {
            const moviesIdsWithDate = await Movie.find({ releaseDate: date });
            const ids = moviesIdsWithDate.map(item => item._id.toString());
            moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithDate", moviesIds)
        }

        if(actor) {
            const actors = await Actor.aggregate([
                {
                    $match: {
                        name: { $regex: actor as string, $options: "i" }
                    }
                }
            ]);
            const actorsIds = actors.map(item => item._id.toString());
            const moviesIdsWithActor = await ActorMovie.find({
                actor: {$in: actorsIds}
            });
            const ids = moviesIdsWithActor.map(item => item._id.toString());
            moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithActor", moviesIds)
        }

        const movies = await Movie.find({ _id: { $in: Array.from(moviesIds) }});

        res.json(movies);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

export default {
    getListOfMovies
};

