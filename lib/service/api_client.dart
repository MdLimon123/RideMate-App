import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/models/error_response.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/utils/app_constants.dart';



class ApiClient extends GetxService {
  static var client = http.Client();
  static const String noInternetMessage =
      "Sorry! Something went wrong please try again";
  static const int timeoutInSeconds = 30;

  static String bearerToken = "";

  static Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      http.Response response = await client
          .get(
            Uri.parse(ApiConstant.baseUrl + uri),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> postData(
    String uri,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      // 'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');
      debugPrint("Full API URL: ${ApiConstant.baseUrl + uri}");

      http.Response response = await client
          .post(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));

      debugPrint(
        "==========> Response Post Method :------ : ${response.statusCode}",
      );
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


static Future<Response> postMultipartData1(
  String uri,
  Map<String, String> body, {
  required List<MultipartBody> multipartBody,
  Map<String, String>? headers,
}) async {
  try {
    final bearerToken =
        await PrefsHelper.getString(AppConstants.bearerToken);

    final mainHeaders = {
      'Authorization': 'Bearer $bearerToken',
      // ❌ NEVER set Content-Type manually for multipart
    };

    debugPrint('====> API Call: $uri');
    debugPrint('====> Headers: $mainHeaders');
    debugPrint('====> Fields: $body');
    debugPrint('====> Files count: ${multipartBody.length}');

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstant.baseUrl + uri),
    );

    request.headers.addAll(headers ?? mainHeaders);
    request.fields.addAll(body);

    for (final file in multipartBody) {
      debugPrint(
        'Uploading → ${file.key}: ${file.file.path} '
        '(exists: ${file.file.existsSync()})',
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          file.key,
          file.file.path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('====> Response Code: ${response.statusCode}');
    debugPrint('====> Response Body: ${response.body}');

    return handleResponse(response, uri);
  } catch (e) {
    debugPrint('❌ Multipart Exception: $e');
    return const Response(
      statusCode: 1,
      statusText: noInternetMessage,
    );
  }
}





  static Future<Response> postMultipartData(
    String uri,
    Map<String, String> body, {
    required List<MultipartBody> multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} picture');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstant.baseUrl + uri),
      );
      request.headers.addAll(headers ?? mainHeaders);
      for (MultipartBody element in multipartBody) {
        request.files.add(
          await http.MultipartFile.fromPath(element.key, element.file.path),
        );
      }
      request.fields.addAll(body);
      http.Response _response = await http.Response.fromStream(
        await request.send(),
      );
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchMultipartData(
    String uri,
    Map<String, String> body, {
    required List<MultipartBody> multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      String? bearerToken = await PrefsHelper.getString(
        AppConstants.bearerToken,
      );

      var mainHeaders = {'Authorization': 'Bearer $bearerToken'};

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstant.baseUrl + uri),
      );
      request.headers.addAll(headers ?? mainHeaders);

      // Add files safely
      for (MultipartBody element in multipartBody) {
        if (!element.file.existsSync()) {
          print("File not found: ${element.file.path}");
          continue;
        }

        String extension = element.file.path.split('.').last.toLowerCase();
        String mimeType = 'image/jpeg';
        if (extension == 'png') mimeType = 'image/png';
        if (extension == 'jpg' || extension == 'jpeg') mimeType = 'image/jpeg';
        if (extension == 'avif') mimeType = 'image/avif';

        try {
          request.files.add(
            await http.MultipartFile.fromPath(
              element.key,
              element.file.path,
              contentType: MediaType(
                mimeType.split('/')[0],
                mimeType.split('/')[1],
              ),
            ),
          );
        } catch (e) {
          print("Error adding file: $e");
        }
      }

      request.fields.addAll(body);

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      String responseString = await streamedResponse.stream.bytesToString();

      print("Status code: ${streamedResponse.statusCode}");
      print("Response string: $responseString");

      return Response(
        statusCode: streamedResponse.statusCode,
        body: responseString,
      );
    } catch (e) {
      print("PATCH Multipart Exception: $e");
      return Response(statusCode: 0, body: e.toString());
    }
  }

  static Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    ///application/x-www-form-urlencoded
    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .put(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> putMultipartData(
    String uri,
    Map<String, String> body, {
    required List<MultipartBody> multipartBody,
    Map<String, String>? headers,
  }) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $bearerToken',
      };
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} picture');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstant.baseUrl + uri),
      );
      request.headers.addAll(headers ?? mainHeaders);
      for (MultipartBody element in multipartBody) {
        for (MultipartBody element in multipartBody) {
          request.files.add(
            await http.MultipartFile.fromPath(element.key, element.file.path),
          );
        }
      }

      request.fields.addAll(body);

      http.Response _response = await http.Response.fromStream(
        await request.send(),
      );
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .patch(
            Uri.parse(ApiConstant.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? mainHeaders,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // static Future<Response> patchMultipartData(
  //     String uri,
  //     Map<String, String> body, {
  //       required List<MultipartBody> multipartBody,
  //       Map<String, String>? headers,
  //     }) async {
  //   try {
  //     bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
  //
  //     var mainHeaders = {
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //       'Authorization': 'Bearer $bearerToken',
  //     };
  //
  //     debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
  //     debugPrint('====> API Body: $body with ${multipartBody.length} picture');
  //
  //     var request = http.MultipartRequest(
  //       'PATCH',
  //       Uri.parse(ApiConstant.baseUrl + uri),
  //     );
  //     request.headers.addAll(headers ?? mainHeaders);
  //
  //     for (var part in multipartBody) {
  //       if (part.file.existsSync()) {
  //         final mimeType = lookupMimeType(part.file.path) ?? 'image/jpeg';
  //         final multipartFile = await http.MultipartFile.fromPath(
  //           part.key,
  //           part.file.path,
  //           contentType: MediaType.parse(mimeType),
  //         );
  //         request.files.add(multipartFile);
  //       }
  //     }
  //
  //     request.fields.addAll(body);
  //
  //     http.Response _response = await http.Response.fromStream(
  //       await request.send(),
  //     );
  //
  //     return handleResponse(_response, uri);
  //   } catch (e) {
  //     debugPrint("Upload Error: $e");
  //     return const Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }

  static Future<Response> deleteData(
    String uri, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Call: $uri\n Body: $body');

      http.Response response = await http
          .delete(
            Uri.parse(ApiConstant.baseUrl + uri),
            headers: headers ?? mainHeaders,
            body: body,
          )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Response handleResponse(http.Response response, String uri) {
    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      debugPrint("response ${response0.body.runtimeType}");
      ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
      debugPrint("${errorResponse.statusCode}");
      response0 = Response(
        statusCode: response0.statusCode,
        body: response0.body,
        statusText: errorResponse.message,
      );

      // if(_response.body.toString().startsWith('{errors: [{code:')) {
      //   ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
      //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      // }else if(_response.body.toString().startsWith('{message')) {
      //   _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      // }
      // response0 = Response(
      //   statusCode: response0.statusCode,
      //   body: response0.body,
      // );
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }

    debugPrint(
      '====> API Response: [${response0.statusCode}] $uri\n${response0.body}',
    );
    // log.e("Handle Response error} ");
    return response0;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
