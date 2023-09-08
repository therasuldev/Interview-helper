import 'package:flutter/material.dart';
import 'package:interview_prep/gen/assets.gen.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

class RateApp {
  RateApp._();
  static RatingDialog ratingDialog(BuildContext context) {
    return RatingDialog(
      initialRating: 5.0,
      title: const Text(
        'Rating Dialog',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      image: Image.asset(
        Assets.app.path,
        height: MediaQuery.of(context).size.height * .2,
      ),
      submitButtonText: 'Submit',
      commentHint: 'Tell us your comment',
      onSubmitted: (_) {
        //TODO: change androidAppId
        StoreRedirect.redirect(androidAppId: "com.riddle.game.en");
      },
    );
  }
}
