const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.notify = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Only authenticated users can send notifications.",
    );
  }

  const passengerDocId = data.passengerId;
  const title = data.title || "Your ride has arrived!";
  const body = data.body || "Please meet the driver at the pickup point.";

  try {
    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(passengerDocId)
      .get();

    if (!userDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Passenger not found");
    }

    const fcmToken = userDoc.data().fcmToken;

    if (!fcmToken) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Passenger has no FCM token",
      );
    }

    const payload = {
      token: fcmToken,
      notification: {
        title: title,
        body: body,
      },
      android: {
        priority: "high",
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
          },
        },
      },
    };

    const response = await admin.messaging().send(payload);

    return { success: true, response };
  } catch (error) {
    console.error("Notification error:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to send notification",
    );
  }
});
