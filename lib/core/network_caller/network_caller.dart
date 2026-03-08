import 'package:api_integration_app/core/network_caller/network_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkCaller {
  //Get req
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Request failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //post Req
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Request failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //put Req
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Update failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //Delete rew
  static Future<NetworkResponse> deleteRequest({required String url}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Delete failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}
