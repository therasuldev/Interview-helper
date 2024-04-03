import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_helper/src/utils/index.dart';

import '../../../config/network/connectivity_config.dart';
import '../../../domain/models/index.dart';
import '../../provider/cubit/feedback/feedback_cubit.dart';
import '../../widgets/index.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final message = TextEditingController();
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final feedbackKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    message.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contactUs.contactUs'.tr()), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: 1,
                key: emailKey,
                controller: email,
                style: ViewUtils.ubuntuStyle(),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'contactUs.yourEmail'.tr(),
                  hintStyle: ViewUtils.ubuntuStyle(),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (value) => FormValidate.emailFieldIsValidate(value),
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 7,
                key: feedbackKey,
                controller: message,
                style: ViewUtils.ubuntuStyle(),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'contactUs.writeFeedback'.tr(),
                  hintStyle: ViewUtils.ubuntuStyle(),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (value) => FormValidate.feedbackFieldIsValidate(value),
              ),
              const Spacer(),
              Center(
                child: _FeedbackButton(
                  email: email,
                  message: message,
                  formKey: formKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackButton extends StatefulWidget {
  const _FeedbackButton({
    required this.email,
    required this.message,
    required this.formKey,
  });

  final TextEditingController email;
  final TextEditingController message;

  final GlobalKey<FormState> formKey;

  @override
  State<_FeedbackButton> createState() => _FeedbackButtonState();
}

class _FeedbackButtonState extends State<_FeedbackButton> {
  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      _checkConnectivityStatus(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _checkConnectivityStatus(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        break;
      default:
        ViewUtils.showInterviewHelperSnackBar(
          snackbarTitle: 'connectionProblem'.tr(),
          backgroundColor: Colors.red,
        );
        break;
    }
  }

  void _sendFeedback() async {
    final connectivity = await ConnectivityService().hasActiveInternetConnection();
    if (!connectivity) return;

    final isValidate = widget.formKey.currentState?.validate() ?? false;
    if (!isValidate) return;

    final message = Message(email: widget.email.text, message: widget.message.text);
    if (mounted) context.read<FeedbackCubit>().send(message: message);
  }

  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.sizeOf(context).width * .9,
      child: OutlinedButton(
        onPressed: () => _sendFeedback(),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          // side: MaterialStateProperty.all(const BorderSide(color: AppColors.primary, strokeAlign: 10)),
        ),
        child: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            switch (state.event) {
              case FeedbackEvents.success:
                ViewUtils.showInterviewHelperSnackBar(
                  snackbarTitle: 'contactUs.thankforfeedback'.tr(),
                  backgroundColor: Colors.green,
                );
                break;
              case FeedbackEvents.failure:
                ViewUtils.showInterviewHelperSnackBar(
                  snackbarTitle: state.exception!.description,
                  backgroundColor: Colors.red,
                );
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            if (state.loading) return const KSpinKitCircle();
            return Text('contactUs.sendFeedback'.tr(), style: ViewUtils.ubuntuStyle());
          },
        ),
      ),
    );
  }
}
