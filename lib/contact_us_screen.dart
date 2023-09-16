import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_prep/app_colors.dart';
import 'package:interview_prep/core/model/email/emailjs.dart';
import 'package:interview_prep/core/provider/cubit/feedback/feedback_cubit.dart';
import 'package:interview_prep/core/service/network_manager.dart';
import 'package:interview_prep/form_validate.dart';
import 'package:interview_prep/spinkit_circle_loading_widget.dart';
import 'package:interview_prep/view/utils/utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});
  
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController message = TextEditingController();
  final TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final feedbackKey = GlobalKey<FormFieldState>();

  
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
                  validator: (value) =>
                      FormValidate.emailFieldIsValidate(value),
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
                  validator: (value) =>
                      FormValidate.feedbackFieldIsValidate(value),
                ),
                const Spacer(),
                Center(
                  child: _SendFeedbackButton(
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

class _SendFeedbackButton extends StatelessWidget {
  const _SendFeedbackButton({
    required this.email,
    required this.message,
    required this.formKey,
  }) : super();

  final TextEditingController email;
  final TextEditingController message;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .9,
      child: StreamBuilder(
        stream: ConnectivityService().controller.stream,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: () {
              final isValidate = formKey.currentState?.validate() ?? false;
              if (!isValidate && snapshot.data != ConnectivityStatus.online) {
                return;
              }
              final msgParams =
                  MSGParams(email: email.text, message: message.text);
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
          );
        },
      ),
    );
  }
}
