import {Request, Response} from "express";
import Movie from "../models/movie";
import mongoose from "mongoose";
import GenreMovie from "../models/genre_movie";
import ActorMovie from "../models/actor_movie";
import Session from "../models/session";
import Cinema from "../models/cinema";
import Hall from "../models/hall";

const getListOfMovies = async (req: Request, res: Response) => {
    try {
        const { cinema, city, genres, date, actor, query } = req.query;

        const pipeline = [];
        const moviesIds = new Set<string>();


        if (city) {
            const cinemas = await Cinema.find();
            const cinemasIds = cinemas.map(item => item._id);
            console.log(cinemas);
            console.log(cinemasIds);
            const halls = await Hall.find({
                cinema_id : { $in: cinemasIds }
            })
            const hallsIds = halls.map(item => item._id);
            console.log(halls)
            const sessions =  await Session.find({
                hall : { $in: hallsIds }
            });
            console.log(sessions)
            const moviesIds = sessions.map(item => item.movie);

            console.log(moviesIds);
            //
            // pipeline.push({
            //         $lookup: {
            //             from: "cinemas",
            //             localField: "_id",
            //             foreignField: "city_id",
            //             as: "cinemas"
            //         }
            //     },
            //     {
            //         $unwind: "$cinemas"
            //     },
            //     {
            //         $match: {
            //             "cinemas.city_id": new mongoose.Types.ObjectId(city as string)
            //         }
            //     });

        }
        // if (cinema) {
        //     pipeline.push({
        //             $lookup: {
        //                 from: "cinemas",
        //                 localField: "_id",
        //                 foreignField: "city_id",
        //                 as: "cinemas"
        //             }
        //         },
        //         {
        //             $unwind: "$cinemas"
        //         },
        //         {
        //             $match: {
        //                 "cinemas._id": new mongoose.Types.ObjectId(cinema as string)
        //             }
        //         });
        // }

        //
        // if (genres) {
        //     const genreIds = (genres as string[]).map(id => new mongoose.Types.ObjectId(id));
        //     pipeline.push({
        //             $lookup: {
        //                 from: "genremovies",
        //                 localField: "_id",
        //                 foreignField: "movie",
        //                 as: "genreMovies"
        //             }
        //         },
        //         {
        //             $unwind: "$genreMovies"
        //         },
        //         {
        //             $match: {
        //                 "genreMovies.genre": { $in: genreIds }
        //             }
        //         });
        // }
        //
        // if (date) {
        //     const parsedDate = new Date(date as string);
        //     pipeline.push({
        //         $match: {
        //             releaseDate: {
        //                 $eq: parsedDate
        //             }
        //         }
        //     });
        // }
        //
        // if (actor) {
        //     pipeline.push({
        //             $lookup: {
        //                 from: "actormovies",
        //                 localField: "_id",
        //                 foreignField: "movie",
        //                 as: "actorMovies"
        //             }
        //         },
        //         {
        //             $unwind: "$actorMovies"
        //         },
        //         {
        //             $lookup: {
        //                 from: "actors",
        //                 localField: "actorMovies.actor",
        //                 foreignField: "_id",
        //                 as: "actors"
        //             }
        //         },
        //         {
        //             $unwind: "$actors"
        //         },
        //         {
        //             $match: {
        //                 "actors.name": { $regex: actor as string, $options: "i" }
        //             }
        //         });
        // }
        //
        // if (query) {
        //     pipeline.push({
        //         $match: {
        //             title: { $regex: query as string, $options: "i" }
        //         }
        //     });
        // }

        // Group by movie _id to avoid duplicates after lookups and unwinds
        pipeline.push({
            $group: {
                _id: "$_id",
                title: { $first: "$title" },
                description: { $first: "$description" },
                releaseDate: { $first: "$releaseDate" },
                duration: { $first: "$duration" },
                thumbnail: { $first: "$thumbnail" },
                director: { $first: "$director" },
                rating: { $first: "$rating" }
            }
        });

        const movies = await Movie.aggregate(pipeline).exec();
        res.json(movies);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: "Something went wrong" });
    }
};

export default {
    getListOfMovies
};

