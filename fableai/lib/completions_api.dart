import 'package:flutter/material.dart';
import 'api_key.dart';
import 'completions_request.dart';
import 'package:http/http.dart' as http;
import 'completions_response.dart';
// ignore: library_prefixes

class CompletionsApi {
  // The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  // The headers for the completions endpoint, which are the same for
  // all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIApiKey',
  };

  /// creates a request object, and then fills it in with the prompt, and then sends to request object.
  static Future<CompletionsResponse> getStory() async {
    debugPrint('Sending Request to OpenAI');

    // Generate request object
    CompletionsRequest request = CompletionsRequest(
      model: 'text-babbage-001',
      prompt: "Tell me a story about George Washington",
      maxTokens: 9,
      temperature: .5,
    );

    debugPrint('Sending OpenAI API request with prompt, "${request.prompt}"');

    // This is the part that sends the api request
    http.Response response = await http.post(completionsEndpoint,
        headers: headers, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    // Check to see if there was an error
    if (response.statusCode != 200) {
      debugPrint(
          'Failed to get a prompt with status code, ${response.statusCode}');
    }

    // Converting it to a response object (see completions_response.dart request)
    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    return completionsResponse;
  }
}
