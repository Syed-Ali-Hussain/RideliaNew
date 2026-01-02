const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.checkPendingReservations = functions.pubsub
  .schedule("every 15 minutes")
  .onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const fifteenMinutesFromNow = new Date(now.toMillis() + 15 * 60 * 1000);

    const ridesRef = admin.firestore().collection("rides");
    const querySnap = await ridesRef
      .where("reservation", "==", true)
      .where("availabilityMarked", "==", false)
      .get();

    if (querySnap.empty) {
      console.log("No pending reservations found.");
      return null;
    }

    const batch = admin.firestore().batch();

    querySnap.forEach((doc) => {
      const ride = doc.data();
      const reservationTime = ride.reservationTime;

      if (!reservationTime) return; // skip if no reservationTime

      // Convert Firestore timestamp to Date if needed
      const reservationDate = reservationTime.toMillis
        ? reservationTime.toDate()
        : new Date(reservationTime);

      // Check if reservation time is <= 30 mins from now
      const thirtyMinsBefore = new Date(
        reservationDate.getTime() - 30 * 60 * 1000,
      );

      if (now.toDate() >= thirtyMinsBefore && now.toDate() <= reservationDate) {
        // Mark ride as unaccepted
        batch.update(doc.ref, {
          accepted: false,
          driver: null,
          driverUnavailableCheckAt: admin.firestore.Timestamp.now(),
        });
        console.log(`Ride ${doc.id} marked as unaccepted.`);
      }
    });

    await batch.commit();
    return null;
  });
