import 'dart:convert';

import 'package:dartz/dartz.dart';
import "package:http/http.dart" as http;
import 'package:news_api/core/class/stautscode.dart';
import 'package:news_api/core/functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> getData(String linkUrl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkUrl),
            // body: data,
            headers: {"x-api-key": "fc938f4e95094d6d8d4d359f329b9656"});
        if (response.statusCode == 200) {
          Map responseBody = jsonDecode(response.body);
          print(
              "=================================Crud_Response=================================$responseBody");

          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
