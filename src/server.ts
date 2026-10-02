import express, {
  type Request,
  type Response,
  type NextFunction,
} from "express";
import dotenv from "dotenv";
import app from "./app.js";
import { pool } from "./db/pool.js";

dotenv.config();

const PORT = process.env.PORT || 5010;

app.get("/health", async (req: Request, res: Response, next: NextFunction) => {
  try {
    const dbQuery = await pool.query("SELECT 1 AS ok");
    console.log("--- DATABASE QUERY RESULT ---");
    console.log(dbQuery);
    console.log("-----------------------------");

    res.status(200).json({ status: "healthy", database: "connected" });
  } catch (error) {
    res
      .status(503)
      .json({ status: "unhealthy", reason: "Database connection failed" });
  }
});

app.get("/slow")

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
