import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/network/network_manager.dart';
import '../../../domain/models/models.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../provider/cubit/feedback/feedback_cubit.dart';
import '../../widgets/widgets.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact us',
                  style: ViewUtils.ubuntuStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 1,
                  key: emailKey,
                  controller: email,
                  style: ViewUtils.ubuntuStyle(),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Your email',
                    hintStyle: ViewUtils.ubuntuStyle(),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appColor),
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
                    hintText: 'Write your feedback here...',
                    hintStyle: ViewUtils.ubuntuStyle(),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appColor),
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
      checkConnectivityStatus(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void checkConnectivityStatus(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        break;
      default:
        const snackBar = SnackBar(content: Text('Connection error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
    }
  }

  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      child: OutlinedButton(
        onPressed: () async {
          final connectivity = await ConnectivityService().getConnectivityStatus();
          if (!connectivity) return;

          final isValidate = widget.formKey.currentState?.validate() ?? false;
          if (!isValidate) return;

          final message = Message(email: widget.email.text, message: widget.message.text);
          if (context.mounted) context.read<FeedbackCubit>().send(message: message);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(AppColors.appColor),
          side: MaterialStateProperty.all(const BorderSide(color: AppColors.appColor, strokeAlign: 10)),
        ),
        child: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            switch (state.event) {
              case FeedbackEvents.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    margin: const EdgeInsets.all(10),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Thank you for your feedback.', style: ViewUtils.ubuntuStyle(fontSize: 12)),
                  ),
                );
                break;
              case FeedbackEvents.failure:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    margin: const EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    content: Text(state.exception!.description, style: ViewUtils.ubuntuStyle()),
                  ),
                );
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            if (state.loading) return const KSpinKitCircle();
            return Text('Send feedback', style: ViewUtils.ubuntuStyle());
          },
        ),
      ),
    );
  }
}
