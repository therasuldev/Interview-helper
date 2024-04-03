import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class ViewUtils {
  //for category card [Categories page]
  static categoryCardDecor() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade200),
        borderRadius: BorderRadius.circular(15),
      );

  //for question card [Questions page]
  static questionCardDecor() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      );

  // Ubuntu Google fonts
  static ubuntuStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
    return GoogleFonts.ubuntu(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  // App Snackbar
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showInterviewHelperSnackBar({
    required String snackbarTitle,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsetsDirectional.all(10),
      content: SizedBox(
        height: 35,
        child: Center(
          child: Text(
            snackbarTitle,
            style: ViewUtils.ubuntuStyle(fontSize: 16),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static ratingDialog(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
      child: RatingDialog(
        initialRating: 5.0,
        title: Text(
          'drawer.rateUs'.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        image: Image.asset(
          Assets.appOriginal.path,
          height: MediaQuery.of(context).size.height * .2,
        ),
        enableComment: false,
        submitButtonText: 'submit'.tr(),
        onSubmitted: (_) {
          StoreRedirect.redirect(androidAppId: "com.interview.helper.app");
        },
      ),
    );
  }

  static void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      "https://play.google.com/store/apps/details?id=com.interview.helper.app&hl=en",
      subject: '',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
