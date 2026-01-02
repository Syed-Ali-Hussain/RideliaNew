const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const https = require("https");

exports.stripeWithdrawFunds = functions.https.onRequest((req, res) => {
  try {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    const { amount, destination } = req.body;

    if (!amount || !destination) {
      return res
        .status(400)
        .json({ error: "Amount and destination are required" });
    }

    const stripeSecretKey = functions.config().stripe.secret;

    // Stripe requires amount in cents (integer)
    const payload = `amount=${encodeURIComponent(amount)}&currency=usd&destination=${encodeURIComponent(destination)}`;

    const options = {
      hostname: "api.stripe.com",
      path: "/v1/transfers",
      method: "POST",
      headers: {
        Authorization: `Bearer ${stripeSecretKey}`,
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-Length": Buffer.byteLength(payload),
      },
    };

    const stripeReq = https.request(options, (stripeRes) => {
      let data = "";
      stripeRes.on("data", (chunk) => (data += chunk));
      stripeRes.on("end", () => {
        const parsed = JSON.parse(data);
        if (stripeRes.statusCode >= 200 && stripeRes.statusCode < 300) {
          return res.status(200).json({
            success: true,
            transferId: parsed.id,
          });
        } else {
          return res.status(500).json({
            error: parsed.error?.message || "Stripe API failed",
          });
        }
      });
    });

    stripeReq.on("error", (err) => {
      console.error(err);
      return res.status(500).json({ error: "Stripe API request failed" });
    });

    stripeReq.write(payload);
    stripeReq.end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Server error" });
  }
});
