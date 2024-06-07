import 'package:csa_app/core/networking/api-constants.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/Dashboard/internal-pages/notifications/data/notification-model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NotificationController {
  Future<List<NotificationModel>> fetchNotification(
      int pageSize, int pageNumber) async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
    };

    var dio = Dio();
    dio.options.queryParameters = {
      "page_size": pageSize,
      "page_number": pageNumber
    };
    dio.options.headers.addAll(headers);
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getNotifications);

      if (response.statusCode == 200) {
        // Check if response.data is not null and contains the "data" field
        if (response.data != null && response.data["data"] != null) {
          List<dynamic> allData = [...response.data["data"]];
          List<NotificationModel> notifications = [];

          for (var data in allData) {
            NotificationModel notification = NotificationModel(
              id: data['id'],
              title: data['title'] ?? '',
              body: data['body'] ?? '',
            );
            notifications.add(notification);
          }

          return notifications;
        } else {
          // If response.data is null or "data" field is null, return an empty list
          return [];
        }
      } else {
        debugPrint(response.statusMessage);
        // If there's an error, return an empty list
        return [];
      }
    } catch (e) {
      debugPrint('Error: $e');
      // If there's an error, return an empty list
      return [];
    }
  }

  //prev code

  // Future<List<NotificationModel>> fetchNotification(
  //     int pageSize, int pageNumber) async {
  //   var headers = {
  //     'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
  //   };

  //   var dio = Dio();
  //   dio.options.queryParameters = {
  //     "page_size": pageSize,
  //     "page_number": pageNumber
  //   };
  //   dio.options.headers.addAll(headers);
  //   try {
  //     Response response =
  //         await dio.get(ApiConstants.baseUrl + ApiConstants.getNotifications);

  //     if (response.statusCode == 200) {
  //       List allData = [...response.data["data"]];
  //       List<NotificationModel> notifications = [];

  //       for (var data in allData) {
  //         NotificationModel contact = NotificationModel(
  //           id: data['id'],
  //           title: data['title'] == false ? "" : data['title'],
  //           body: data['body'] == false ? "" : data['body'],
  //         );
  //         notifications.add(contact);
  //       }

  //       return notifications;
  //     } else {
  //       debugPrint(response.statusMessage);
  //       // If there's an error, return an empty list
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     // If there's an error, return an empty list
  //     return [];
  //   }
  // }
}
