import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

import 'package:http/http.dart' as http;

class ContactUsScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  ContactUsScreen({super.key});

  void _sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_o2y9q97';
    const templateId = 'template_gxhao98';
    const userId = '_-E1ndG0CCw8ZD0mS';

    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
          },
        }),
      );
    } catch (_) {}
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
              controller: _userController,
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
                  onPressed: () => _sendEmail(
                    name: _userController.text.trim(),
                    email: _userController.text.trim(),
                    subject: _userController.text.trim(),
                    message: _messageController.text.trim(),
                  ),
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
