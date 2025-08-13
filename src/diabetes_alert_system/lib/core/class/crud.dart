import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:diabetes_alert_system/core/class/statusrequest.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:io';

import '../functions/checkinternet.dart';

String _basicAuth = 'Basic ${base64Encode(utf8.encode('dddd:sdfsdfsdfsdfdsf'))}';
Map<String, String> _myheaders = {
  'authorization': _basicAuth,
};

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (!await checkInternet()) {
        print('[postData] No connectivity → networkFailure');
        return const Left(StatusRequest.networkFailure);
      }

      final response = await http.post(Uri.parse(linkurl), body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map body = jsonDecode(response.body);
        print('[postData] Success → $body');
        return Right(body);
      } else {
        print('[postData] Server error: ${response.statusCode} ${response.body}');
        return const Left(StatusRequest.serverfailure);
      }
    } on SocketException {
      return const Left(StatusRequest.networkFailure);
    } on FormatException catch (e) {
      print("JSON Decoding Error: $e");
      return const Left(StatusRequest.decodingFailure);
    } catch (e) {
      print("Unexpected exception: $e");
      return const Left(StatusRequest.serverException);
    }
  }


  Future<Either<StatusRequest, Map>> addRequestWithImageOne(
      String url, Map data, File? image, [String? namerequest]) async {
    namerequest ??= "files";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_myheaders);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(
        namerequest,
        stream,
        length,
        filename: basename(image.path),
      );
      request.files.add(multipartFile);
    }

    // Add data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    try {
      // Send Request
      var myrequest = await request.send();

      // Get Response Body
      var response = await http.Response.fromStream(myrequest);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Map responsebody = jsonDecode(response.body);

        // Check if "status" key is present in the response
        if (responsebody.containsKey("status")) {
          print(responsebody);
          return Right(responsebody);
        } else {
          // Handle missing required keys as per your requirement
          return const Left(StatusRequest.decodingFailure);
        }
      } else {
        print(response.body);
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      // Handle exceptions during the request or response processing
      print("Exception: $e");
      return const Left(StatusRequest.serverException);
    }
  }
}