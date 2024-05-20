import 'dart:convert';
import 'package:csa_app/core/networking/api-constants.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/branch-academy.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/level.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/main-branch.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/new.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/product.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/features/login/data/user-children.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class HomeController {
  Future<List<UserChildren>> fetchChildren() async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
    };

    var dio = Dio();
    dio.options.headers.addAll(headers);
    dio.options.connectTimeout = const Duration(milliseconds: 10000);

    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getUser);
      if (response.statusCode == 200) {
        List childrenIds = [...response.data["data"]['children_ids']];
        List<UserChildren> children = childrenIds
            .map((e) => UserChildren(
                  id: e['id'],
                  name: e['name'],
                  level: Level(id: e['level']['id'], name: e['level']['name']),
                  img: e['image'] == false
                      ? Uint8List(0)
                      : base64.decode(
                          e['image'],
                        ),
                ))
            .toList();

        return children;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
    return [];
  }

  Future<List<Member>> fetchAllChildren() async {
    try {
      List<UserChildren> children = await fetchChildren();
      List<Member> membersList = children
          .map((e) => Member(name: e.name!, id: e.id!, urlImage: e.img))
          .toList();
      return membersList;
    } catch (e) {
      return [];
    }
  }

  Future<List<New>> fetchAllNews() async {
    var headers = {
      'Connection': 'keep-alive',
    };
    var dio = Dio();
    dio.options.headers.addAll(headers);
    dio.options.connectTimeout = const Duration(seconds: 120);
    dio.options.receiveTimeout = const Duration(seconds: 90);
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getnews);
      if (response.statusCode == 200) {
        List news = [...response.data["data"]];
        List<New> newsList = news
            .map((e) => New(
                  id: e['id'],
                  title: e['title'] == false ? "no name" : e['title'],
                  image: e['image'] == false
                      ? Uint8List(0)
                      : base64.decode(
                          e['image'],
                        ),
                  desscription: e['description'] ?? "",
                  isActive: e['active'],
                ))
            .toList();

        return newsList;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return [];
  }

  Future<List<Program>> fetchAllPrograms() async {
    var dio = Dio();
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getPrograms);
      if (response.statusCode == 200) {
        List news = [...response.data["data"]];

        List<Program> programList = news
            .map((e) => Program(
                  // id: e['id'],
                  name: e['name'] == false ? "" : e['name'],
                  bannerName: e['title'] == false ? "" : e['title'],
                  bannerColor: e['color'] == false ? "" : e['color'],
                  img: e['image'] == false
                      ? Uint8List(0)
                      : base64.decode(e['image']),
                  description:
                      e['description'] == false ? "" : e['description'],
                ))
            .toList();

        return programList;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
    return [];
  }

  Future<List<Product>> fetchProducts() async {
    var dio = Dio();
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getProducts);
      if (response.statusCode == 200) {
        List products = [...response.data["data"]];
        int index = 0;
        List<Product> productsList = products
            .map((e) {
              var branchId = e['branch_ids'][index];
              List<BranchAcademy> branchIds = [];
              if (e['branch_ids'][index]['id'] != false &&
                  e['branch_ids'][index]['name'] != false) {
                branchIds.add(BranchAcademy(
                  id: branchId['id'],
                  name: branchId['name'],
                ));
                index++;
              } else {
                branchIds.add(BranchAcademy(
                  id: 0,
                  name: 'no branch details',
                ));
              }
              return Product(
                id: e['id'],
                name: e['name'],
                img: e['image'] == false
                    ? Uint8List(0)
                    : base64.decode(e['image']),
                isActive: e['active'],
                price: e['price'],
                availableBranchs: branchIds,
              );
            })
            .where((element) => element.isActive == true)
            .toList();

        return productsList;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return [];
  }

  Future<List<MainBranch>> fetchAllBranch() async {
    var dio = Dio();
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getbranch);
      if (response.statusCode == 200) {
        List branches = [...response.data["data"]];
        List<MainBranch> branchList = branches
            .map((e) => MainBranch(
                  name: e['name'],
                  location:
                      e['location'].toString() == "false" ? "" : e['location'],
                  contactNumberOne: e['contact_number'].toString() == "false"
                      ? ""
                      : e['contact_number'],
                  contactNumberTwo: e['contact_number_2'].toString() == "false"
                      ? ""
                      : e['contact_number_2'],
                ))
            .toList();
        return branchList;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return [];
  }

  Future<bool> joinCourseRequest(List<int> membersId, int courseId) async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };

    var dio = Dio();
    dio.options.headers.addAll(headers);
    dio.options.connectTimeout =
        const Duration(seconds: 120); // Increase timeout to 30 seconds
    dio.options.receiveTimeout =
        const Duration(seconds: 90); // Increase receive timeout to 30 seconds
    DateTime now = DateTime.now();
    String requestDate = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(now);
    String reqUrl = ApiConstants.baseUrl + ApiConstants.addRegistration;
    var parentData = await UserSharedPrefrences().getUser();
    try {
      for (int id in membersId) {
        var data = json.encode({
          "params": {
            "data": {
              "student_id": id,
              "parent_id": parentData.id,
              "course_id": courseId,
              "date": requestDate,
            }
          }
        });
        await dio.request(
          reqUrl,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error: $e');
      return false;
    }
  }

  Future<List<Course>> fetchAllCourses() async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
    };

    var dio = Dio();
    dio.options.headers.addAll(headers);

    try {
      Response response =
          await dio.get("${ApiConstants.baseUrl}${ApiConstants.getAllCourses}");
      if (response.statusCode == 200) {
        List courses = [...response.data["data"]];
        List<Course> allCourses = courses
            .map(
              (e) => Course(
                id: e['id'],
                name: e['code'],
                date: e['date'],
                state: 'open',
              ),
            )
            .toList();

        return allCourses;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
    return [];
  }
}
