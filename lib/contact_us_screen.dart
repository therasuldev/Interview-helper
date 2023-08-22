import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class ContactUsScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  ContactUsScreen({super.key});

  void _sendEmail(BuildContext context) async {
    String username = 'rasul.ramixanov@gmail.com';
    String password = 'ramikhanov7';
    //final smtpServer = gmail(username, password);

    // final message = Message()
    //   ..from = Address(username, 'Your Name')
    //   ..recipients.add('rasul.ramixanov@gmail.com') // Developer's email address
    //   ..subject = 'User Feedback / Complaint'
    //   ..text = _messageController.text;

    // try {
    //   final sendReport = await send(message, smtpServer);
    //   print('Message sent: ${sendReport.toString()}');
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Message sent successfully!'),
    //   ));
    // } on MailerException catch (e) {
    //   print('Message not sent. ${e.message}');
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Message could not be sent.'),
    //   ));
    // }

    final Email email = Email(
      body: _messageController.text,
      subject: _emailController.text.trim(),
      recipients: ['rasul.ramixanov@gmail.com'],
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact us',
              style: ViewUtils.ubuntuStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 1,
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Your email',
                hintStyle: ViewUtils.ubuntuStyle(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 7,
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Write your message here...',
                hintStyle: ViewUtils.ubuntuStyle(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * .6,
                child: ElevatedButton(
                  onPressed: () => _sendEmail(context),
                  child: Text('Submit', style: ViewUtils.ubuntuStyle()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
