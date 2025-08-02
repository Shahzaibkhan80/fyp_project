import 'package:http/http.dart' as http;

class N8nWebhookService {
  static Future<void> sendRegistrationToWebhook({
    required String email,
    required String name,
  }) async {
    print('Inside sendRegistrationToWebhook');
    const webhookUrl =
        'https://learningapp.app.n8n.cloud/webhook/1d595f9e-89bb-481e-a0e3-c2fe83df920c';
    try {
      print('Calling webhook...');
      final response = await http.post(
        Uri.parse(webhookUrl),
        body: {
          'email': email,
          'name': name,
        },
      );
      print('Webhook response: ${response.statusCode} - ${response.body}');
      print('Webhook called');
    } catch (e) {
      print('Webhook error: $e');
    }
  }
}
