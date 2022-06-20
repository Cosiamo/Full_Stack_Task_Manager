import 'package:flutter/foundation.dart';
import 'package:flutter_golang_yt/utils/app_constants.dart';
import 'package:get/get.dart';

class DataService extends GetConnect implements GetxService {
    // getting a response object from the server
    // it may take a little time to get the response from the server, so we are returning a future object (why we are using async/await)
  Future<Response> getData(String uri) async {
    if (kDebugMode) {
      print(AppConstants.BASE_URL+uri);
    }
    Response response = await get(
      // use `http://localhost:8080/` for iOS and web
        AppConstants.BASE_URL+uri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
      );

    // returning the response object from the server
    return response;
  }

  Future<Response> postData(String uri, dynamic body) async {
    Response response = await post(
        AppConstants.BASE_URL+uri,
        // body is a json type (has key value pair?)
        body,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
      );

    // returning the response object from the server
    return response;
  }

  Future<Response> updateData(String uri, dynamic body) async {
    Response response = await put(
        AppConstants.BASE_URL+uri,
        // body is a json type (has key value pair?)
        body,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
      );

    // returning the response object from the server
    return response;
  }

  Future<Response> deleteData(String uri) async {
    Response response = await delete(
        AppConstants.BASE_URL+uri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
      );

    // returning the response object from the server
    return response;
  }
}
