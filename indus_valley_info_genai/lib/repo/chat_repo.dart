import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:indus_valley_info_genai/models/chat_message_model.dart';
import 'package:indus_valley_info_genai/utils/constants.dart';

class ChatRepo {
  // static
  static chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey",
          data: {
            "contents": previousMessages.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 0.5,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      return '';
    } 
    catch (e) {
      log(e.toString());
      return '';
    }
  }
}
