import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_golang_yt/services/service.dart';
import 'package:flutter_golang_yt/utils/app_constants.dart';
import 'package:get/get.dart';

// will call DataService from service.dart
// this controller holds the data and talks with the DataService to get the data
class DataController extends GetxController {
  // instantiate an object from DataService
  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;
  Map<String, dynamic> _singleData = {};
  Map<String, dynamic> get singleData => _singleData;

  Future<void> getData() async {
    // _isLoading is set to true because it's loading
    _isLoading = true;
    // since service.getData is returning a Future, we need to use await
    Response response = await service.getData(AppConstants.GET_TASKS);
    if (response.statusCode == 200) {
      // whatever we get from the server we put inside this List
      _myData = response.body;
      print(response.statusCode);
      print("We got the data");
      // will update the data
      // update();
    } else {
      print(response.statusCode);
      print("We didn't get the data");
    }
    _isLoading = false;
    update();
  }

  Future<void> getSingleData(String id) async {
    // _isLoading is set to true because it's loading
    _isLoading = true;
    // since service.getData is returning a Future, we need to use await
    // string interpolation
    // might need to remove the `?`
    Response response =
        await service.getData('${AppConstants.GET_TASK}' '?id=$id');
    if (response.statusCode == 200) {
      // whatever we get from the server we put inside this List
      //_myData = response.body;
      if (kDebugMode) {
        print("We got the single data " + jsonEncode(response.body));
        _singleData = response.body;
      }
      // will update the data
      // update();
    } else {
      print(response.statusCode);
      print("We didn't get any data");
    }
    _isLoading = false;
    update();
  }

  Future<void> postData(String task, String taskDetail) async {
    // _isLoading is set to true because it's loading
    _isLoading = true;
    // since service.getData is returning a Future, we need to use await
    Response response = await service.postData(AppConstants.POST_TASK, {
      "task_name": task,
      "task_detail": taskDetail,
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("Data post successful");
      // will update the data
      // update();
    } else {
      print(response.statusCode);
      print("Data post failed");
    }
    update();
    // might need to add: _isLoading = false;
  }

  Future<void> updateData(String task, String taskDetail, int id) async {
    // _isLoading is set to true because it's loading
    _isLoading = true;
    // since service.getData is returning a Future, we need to use await
    Response response =
        await service.updateData('${AppConstants.UPDATE_TASK}' '?id=$id', {
      "task_name": task,
      "task_detail": taskDetail,
    });
    if (response.statusCode == 200) {
      print(response.statusCode);
      print("Data post successful");
      // will update the data
      // update();
    } else {
      print(response.statusCode);
      print("Data post failed");
    }
    update();
    // might need to add: _isLoading = false;
  }

  Future<void> deleteData(int id) async {
    // _isLoading is set to true because it's loading
    _isLoading = true;
    update();
    // since service.getData is returning a Future, we need to use await
    Response response =
        await service.deleteData('${AppConstants.DELETE_TASK}' '?id=$id');
    if (response.statusCode == 200) {
      print(response.statusCode);
      // will update the data
      // update();
    } else {
      print(response.statusCode);
      print("Data deletion failed");
    }
    // using async/await to make sure we get everything right after a response from the server
    await Future.delayed(Duration(seconds: 1),
      () {
        // setting to false because it's the default state
        _isLoading = false;
        // calling update twice so it knows the variable has changed
        update();
      }
    );
    // might need to add: _isLoading = false;
  }
}
