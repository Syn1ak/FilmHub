import {Request, Response} from "express";
import Movie from "../models/movie";
import Actor from "../models/actor";
import GenreMovie from "../models/genre_movie";
import ActorMovie from "../models/actor_movie";
import Session from "../models/session";
import Cinema from "../models/cinema";
import Hall from "../models/hall";
import Review from "../models/rewiew";
import mongoose from "mongoose";

const getListOfMovies = async (req: Request, res: Response) => {
    try {
        const {
            cinema,
            city,
            genres,
            date,
            actor,
            query
        } = req.query;
        const today = new Date();

        if (!city && !genres && !cinema && !date && !actor && !query) {
            const allMovies = await Movie.find({releaseDate: {$lt: today}});
            res.json(allMovies);
            return;
        }

        let moviesIds = new Set<string>();

        if (city) {
            const cinemas = await Cinema.find({city_id: city});
            let cinemasIds = cinemas.map(item => item._id);
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

        if (cinema) {
            const cinemas = await Cinema.find({_id: cinema});
            let cinemasIds = cinemas.map(item => item._id);
            const halls = await Hall.find({
                cinema_id: {$in: cinemasIds}
            })
            const hallsIds = halls.map(item => item._id);
            const sessions = await Session.find({
                hall: {$in: hallsIds}
            });
            const ids = sessions.map(item => item.movie.toString());
            if (!city) moviesIds = new Set<string>([...ids]);
            else moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIds", moviesIds)
        }

        if (genres) {
            const genresArr = (genres as string).split(',');
            const moviesIdsWithGenre = await GenreMovie.find({genre: {$in: genresArr}});
            const ids = moviesIdsWithGenre.map(item => item.movie.toString());
            if (!city && !cinema) moviesIds = new Set<string>([...ids]);
            else moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithGenre", moviesIds);
        }

        if (date) {
            const moviesIdsWithDate = await Movie.find({releaseDate: date});
            const ids = moviesIdsWithDate.map(item => item._id.toString());
            if (!city && !cinema && !genres) moviesIds = new Set<string>([...ids]);
            else moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithDate", moviesIds)
        }

        if (actor) {
            const actors = await Actor.aggregate([{
                $match: {
                    name: {$regex: actor as string, $options: "i"}
                }
            }]);
            const actorsIds = actors.map(item => item._id.toString());
            const moviesIdsWithActor = await ActorMovie.find({
                actor: {$in: actorsIds}
            });
            const ids = moviesIdsWithActor.map(item => item.movie.toString());
            if (!city && !cinema && !genres && !date) moviesIds = new Set<string>([...ids]);
            else moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("moviesIdsWithActor", moviesIds)
        }

        if (query) {
            const moviesByQuery = await Movie.aggregate([{
                $match: {
                    title: {$regex: query as string, $options: "i"}
                }
            }])
            const ids = moviesByQuery.map(item => item.movie.toString());
            if (!city && !cinema && !genres && !date && !actor) moviesIds = new Set<string>([...ids]);
            else moviesIds = new Set<string>(ids.filter(i => moviesIds.has(i)));
            console.log("query", moviesIds)
        }

        const movies = await Movie.find({_id: {$in: Array.from(moviesIds)}, releaseDate: {$lt: today}});

        res.json(movies);
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
};

const getMovieById = async (req: Request, res: Response) => {
    try {
        const {movie_id} = req.query;

        const movie = await Movie.findOne({_id: movie_id});
        if (!movie) return res.status(401).json({message: "Cannot find movie by that id "});
        const actorsMovie = await ActorMovie.find({movie: movie_id}).populate("actor");
        const actors = actorsMovie.map(item => item.actor);
        const genresMovies = await GenreMovie.find({movie: movie_id}).populate("genre");
        const genres = genresMovies.map(item => item.genre);
        const reviews = await Review.find({movie: movie_id}).populate("user");
        const result = {
            actors,
            genres,
            reviews
        }
        res.json(result);
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
}

const getFuturePremiere = async (req: Request, res: Response) => {
    try {
        const today = new Date();
        const futureMovie = await Movie.find({releaseDate: {$gt: today}});
        res.json(futureMovie);
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
}

const addReviewToMovie = async (req: Request, res: Response) => {
    try {
        console.log(req.body)
        const {movie_id, user_id, comment, rating} = req.body;
        console.log(movie_id, user_id, comment, rating);
        if (!movie_id || !user_id || !comment || !rating) {
            return res.status(400).json({error: 'All fields are required and rating must be a number'});
        }

        const newReview = new Review({
            movie: new mongoose.Types.ObjectId(movie_id as string),
            user: new mongoose.Types.ObjectId(user_id as string),
            rating: +rating,
            comment: comment
        });

        await newReview.save();
        const allRatings = await Review.find({movie: movie_id}, 'rating');
        const totalRating = allRatings.reduce((accumulator, currentValue) => {
            return currentValue.rating != null ? accumulator + currentValue.rating : accumulator;
        }, 0);
        const averageRating = totalRating / allRatings.length;
        await Movie.updateOne(
            {_id: movie_id},
            {
                $set: {rating: averageRating}
            });
        return res.status(201).json(newReview);
    } catch (error) {
        console.error(error);
        return res.status(500).json({message: "Something went wrong"});
    }
}

export default {
    getListOfMovies,
    getMovieById,
    getFuturePremiere,
    addReviewToMovie
};

