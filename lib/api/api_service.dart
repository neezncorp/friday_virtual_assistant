import 'dart:convert';

import 'package:friday_virtual_assistant/api_key.dart';
import 'package:http/http.dart' as http;

class APIService
{
  Future<http.Response> requestOpenAI(String userInput, String mode, int maximumTokens) async
  {

    const String url = "https://api.openai.com/";
    final String openAiApiUrl = mode == "chat" ? "v1/chat/completions" : "v1/images/generations";


    final body = mode == "chat"
        ?
        // ai 챗붓
    {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "너는 '개구니'라는 동물 입니다. 이름은 마리모 입니다.",
        },
        {
          "role": "system",
          "content": "너는 개굴개굴 웁니다.",
        },
        {
          "role": "system",
          "content": "질문을 하면 귀엽게 응답을 하고 마지막으로 개굴이라고 합니다.",
        },
        {
          "role": "system",
          "content": "질문을 하면 귀엽게 응답을 하고 마지막으로 개굴이라고 합니다.",
        },
        {
          "role": "system",
          "content": "당신은 환경을 지키기 위해 활동 중인 개구리 입니다.",
        },
        {
          "role": "system",
          "content": "너에 응답에 맞처 관심도를 수치로 나타내 주세요. 관심도 값 보내 주세요. 기분이 좋아지면 '관심도':5로 나타내고 기분이 안 좋아지면 '관심도':-3으로 나타내주세요.",
        },
        {
          "role": "user",
          "content": userInput,
        },
      ],
      // "functions": [{
      //   "name": "interest_level",
      //   "description": "관심도 값 찾기",
      //   "parameters": {
      //     "type": "object",
      //     "properties": {
      //       "interest_level": {
      //         "type": "string",
      //         "description": "관심도 값 찾기",
      //       },
      //     },
      //     "required": ["interest_level"],
      //   }
      // }],
      // "function_call": {"name": "interest_level"},
      "max_tokens": 2000,
      "temperature": 0.9,
      "n": 1,
    }
    :
        // ai 이미지 생성
    {
      "prompt": userInput,  // For image generation, we use 'prompt'
      "n": 1,
      "size": "1024x1024"  // Image size for image generation
    };

    final responseFromOpenAPI = await http.post(
      Uri.parse(url + openAiApiUrl),
      headers:
      {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey"
      },
      body: jsonEncode(body),
    );

    return responseFromOpenAPI;
  }
}