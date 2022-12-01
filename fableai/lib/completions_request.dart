import 'dart:convert';

/// Represents the parameters used in the body of a request to the OpenAI completions endpoint.
class CompletionsRequest {
  final String model;
  final String prompt;
  final int maxTokens;
  final double? temperature;

  CompletionsRequest({
    required this.model,
    required this.prompt,
    required this.maxTokens,
    required this.temperature,
  });

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'model': model,
      'prompt': prompt,
      'max_tokens': maxTokens,
    };

    if (temperature != null) {
      jsonBody.addAll({'temperature': temperature});
    }

    return json.encode(jsonBody);
  }
}
