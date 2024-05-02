import 'package:flutter/cupertino.dart';

import '../services/dio_service.dart';

class ChatRepository {
  DioService dioService = DioService(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateMessage',
  );

  Future<String> generateContent(List<Map> context) async {
    final response = await dioService.post(
      '',
      {
        'contents': context,
      },
    );
    debugPrint(response.data.toString());
    return response.data['candidates'][0]['content']['parts'][0]['text'];
  }
}