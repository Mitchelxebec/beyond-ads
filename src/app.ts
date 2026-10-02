import express from "express";
import testRoute from "./routes/test.js";

const app = express();

app.use(express.json());

app.use("/posts", testRoute);

export default app;
