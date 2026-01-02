const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const https = require("https");

exports.stripePayoutAccount = functions.https.onRequest(async (req, res) => {
  try {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    const { email } = req.body;

    if (!email) {
      return res.status(400).json({ error: "Email is required" });
    }

    const stripeSecretKey = functions.config().stripe.secret;

    // Create x-www-form-urlencoded payload manually
    const payload = `type=express&email=${encodeURIComponent(email)}&capabilities[transfers][requested]=true&capabilities[card_payments][requested]=true`;

    const options = {
      hostname: "api.stripe.com",
      path: "/v1/accounts",
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
          return res.status(200).json({ success: true, accountId: parsed.id });
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
