import Router, {
  type Request,
  type Response,
  type NextFunction,
} from "express";
import { ApiError } from "../utils/ApiError.js";

const router = Router();

// 'async' is no longer strictly needed here since we removed the await
router.post("/", (req: Request, res: Response, next: NextFunction) => {
  try {
    let data = [];

    const body = req.body?.title;
    if (!body) throw new ApiError(400, "Missing title body");

    data.push(body);

    const userEmail = () => {
      return "Your email";
    };

    // 1. Send the response to Postman IMMEDIATELY
    res.status(201).json({
      success: true,
      message: data,
      // You cannot send the email value here because it hasn't generated yet!
      status: "Background task started",
    });

    // 2. This runs in the background 2 seconds AFTER the response is sent
    setTimeout(() => {
      try {
        const email = userEmail();
        console.log(`Background task complete! Generated: ${email}`);
        // Perform background work here (e.g., save to DB, send an actual email)
      } catch (error) {
        console.error("❌ Background task failed:", error);
      }
    }, 2000);

  } catch (error) {
    next(error);
  }
});

export default router;
