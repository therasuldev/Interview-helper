import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_prep/app_colors.dart';
import 'package:interview_prep/core/model/email/emailjs.dart';
import 'package:interview_prep/core/provider/feedback_cubit/feedback_cubit.dart';
import 'package:interview_prep/form_validate.dart';
import 'package:interview_prep/spinkit_circle_loading_widget.dart';
import 'package:interview_prep/view/utils/utils.dart';

class ContactUsScreen extends StatelessWidget {
  final TextEditingController _message = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _feedbackKey = GlobalKey<FormFieldState>();

  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
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
                  key: _emailKey,
                  controller: _email,
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
                  validator: (value) =>
                      FormValidate.emailFieldIsValidate(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 7,
                  key: _feedbackKey,
                  controller: _message,
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
                  validator: (value) =>
                      FormValidate.feedbackFieldIsValidate(value),
                ),
                const Spacer(),
                Center(
                  child: _SendFeedbackButton(
                    email: _email,
                    message: _message,
                    formKey: _formKey,
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

class _SendFeedbackButton extends StatelessWidget {
  const _SendFeedbackButton({
    required TextEditingController email,
    required TextEditingController message,
    required this.formKey,
  })  : _email = email,
        _message = message;

  final TextEditingController _email;
  final TextEditingController _message;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(
        onPressed: () {
          final isValidate = formKey.currentState?.validate() ?? false;
          if (!isValidate) return;
          final msgParams =
              MSGParams(email: _email.text, message: _message.text);
          context.read<FeedbackCubit>().send(msgParams: msgParams);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(AppColors.appColor),
          side: MaterialStateProperty.all(
              const BorderSide(color: AppColors.appColor, strokeAlign: 10)),
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
                    content: Text('Thank you for your feedback.',
                        style: ViewUtils.ubuntuStyle(fontSize: 12)),
                  ),
                );
                break;
              case FeedbackEvents.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    margin: const EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    content: Text(state.exception!.description,
                        style: ViewUtils.ubuntuStyle()),
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
