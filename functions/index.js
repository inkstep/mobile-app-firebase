const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.sendfirstArtistResponseNotification = functions.firestore.document('journeys/{journeyid}/stage/')
    .onUpdate(async (change, context) async => {
      const userId = change.after.data().auth_uid;


      if (change.after.data().stage == 1) {
          // Notification details.
            const payload = {
              notification: {
                title: 'Your artist has replied!',
                body: 'Your artist has sent you a quote',
                sound: 'default'
              }
            };

            // Send notifications to all tokens.
            await admin.messaging().sendToDevice(auth_uid, payload);
      }
    });
