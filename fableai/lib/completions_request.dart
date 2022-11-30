import 'dart:convert';

import 'package:http/http.dart';

/// Represents the parameters used in the body of a request to the OpenAI completions endpoint.
class CompletionsRequest {
  final String model;
  final String prompt;
  final int maxTokens;
  final double? temperature;
  final int? topP;
  final int? n;
  final bool? stream;
  final int? longprobs;
  final String? stop;

  CompletionsRequest({
    required this.model,
    required this.prompt,
    required this.maxTokens,
    required this.temperature,
    this.topP,
    this.n,
    this.stream,
    this.longprobs,
    this.stop,
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

    if (topP != null) {
      jsonBody.addAll({'top_p': topP});
    }

    if (n != null) {
      jsonBody.addAll({'n': n});
    }

    if (stream != null) {
      jsonBody.addAll({'stream': stream});
    }

    if (longprobs != null) {
      jsonBody.addAll({'longprobs': longprobs});
    }

    if (stop != null) {
      jsonBody.addAll({'stop': stop});
    }

    return json.encode(jsonBody);
  }
}

class CompletionsResponse {
  final String? id;
  final String object;
  final int? created;
  final String? model;
  final List<dynamic>? choices; // This list contains the completions
  final Map<String, dynamic>? usage;
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;
  final String? firstCompletion;

  const CompletionsResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.firstCompletion,
  });

  /// Returns a [CompletionResponse] from the JSON obtained from the
  /// completions endpoint.
  factory CompletionsResponse.fromResponse(Response response) {
    // Get the response body in JSON format
    Map<String, dynamic> responseBody = json.decode(response.body);

    // Parse out information from the response
    Map<String, dynamic> usage = responseBody['usage'];

    // Parse out the choices
    List<dynamic> choices = responseBody['choices'];

    // Get the text of the first completion
    String firstCompletion = choices[0]['text'];

    return CompletionsResponse(
      id: responseBody['userId'],
      object: responseBody['id'],
      created: responseBody['title'],
      model: responseBody['model'],
      choices: choices,
      usage: usage,
      promptTokens: usage['prompt_tokens'],
      completionTokens: usage['completion_tokens'],
      totalTokens: usage['total_tokens'],
      firstCompletion: firstCompletion,
    );
  }
}
