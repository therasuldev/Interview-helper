class EmailJS {
  final String _userId = '_-E1ndG0CCw8ZD0mS';
  final String _serviceId = 'service_o2y9q97';
  final String _templateId = 'template_gxhao98';

  final MSGParams msgParams;
  EmailJS({required this.msgParams});

  Map<String, dynamic> toJson() {
    return {
      'user_id': _userId,
      'service_id': _serviceId,
      'template_id': _templateId,
      'template_params': msgParams.toJson(),
    };
  }
}

class MSGParams {
  final String email;
  final String message;
  MSGParams({required this.email, required this.message});

  Map<String, dynamic> toJson() {
    return {'user_email': email.trim(), 'user_message': message.trim()};
  }
}
