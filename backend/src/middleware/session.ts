import { Request, Response, NextFunction } from "express";

interface Credentials {
  email: string;
  password: string;
}

class Session {
  static #instance: Session;

  user: Credentials | null = null;

  private constructor() {}

  public static get instance(): Session {
    if (!Session.#instance) {
      Session.#instance = new Session();
    }
    return Session.#instance;
  }

  public getUserFromSession() {
    return this.user;
  }

  public setSessionUser(credentials: { email: string; password: string }) {
    this.user = credentials;
  }
}

export const session = Session.instance;

export const sessionCheck = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!session.getUserFromSession()) return res.sendStatus(401);
  next();
};
