const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const https = require("https");
exports.stripeCheckTotalBalance = functions.https.onRequest((req, res) => {
  try {
    if (req.method !== "GET") {
      return res.status(405).send("Method Not Allowed");
    }

    const stripeSecretKey = functions.config().stripe.secret;

    const options = {
      hostname: "api.stripe.com",
      path: "/v1/balance",
      method: "GET",
      headers: {
        Authorization: `Bearer ${stripeSecretKey}`,
      },
    };

    const stripeReq = https.request(options, (stripeRes) => {
      let data = "";
      stripeRes.on("data", (chunk) => (data += chunk));
      stripeRes.on("end", () => {
        const parsed = JSON.parse(data);
        if (stripeRes.statusCode >= 200 && stripeRes.statusCode < 300) {
          return res.status(200).json({ success: true, balance: parsed });
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

    stripeReq.end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Server error" });
  }
});
