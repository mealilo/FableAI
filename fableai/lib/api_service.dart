import 'dart:developer';

import 'package:fableai/constants.dart';
import 'package:fableai/aiResponse.dart';
//import 'package:fableai/user_model.dart';
import 'package:http/http.dart' as http;

// class ApiService {
//   Future<List<UserModel>?> getUsers() async {
//     try {
//       var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<UserModel> _model = userModelFromJson(response.body);
//         return _model;
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }

class ApiService {
  Future<AiResponse?>? getaiResponse() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        AiResponse model = aiResponseFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
