import 'package:csa_app/core/networking/api-constants.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/course.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/creteria.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution-line.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/level-expecation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EvaluateController {
  // List<UserChildren> children = [];
  // List<Member> membersList = [];
  Future<List<Course>> fetchCourses(int memberId) async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
    };

    var dio = Dio();
    dio.options.headers.addAll(headers);

    try {
      Response response = await dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.getCourses}?student_id=$memberId");
      if (response.statusCode == 200) {
        List courses = [...response.data["data"]];
        List<Course> allCourses = courses
            .map(
              (e) => Course(
                id: e['id'],
                name: e['display_name'],
                date: e['date'],
                state: e['state'],
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

  Future<List<Evalution>> fetchStudentCourse(int memberId, int courseId) async {
    var headers = {
      'Authorization': 'Bearer ${await UserSharedPrefrences().getToken()}',
    };

    var dio = Dio();
    dio.options.headers.addAll(headers);

    try {
      Response response = await dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.getEvalution}?student_id=$memberId&course_id=$courseId");
      if (response.statusCode == 200) {
        List evalution = [...response.data["data"]];
        List<Evalution> allEvalution = evalution.map((e) {
          List<dynamic> expectationIds =
              e['current_level_id']['expectation_ids'] ?? [];
          List<LevelExpectaion> expectations =
              expectationIds.map((expectation) {
            return LevelExpectaion(name: expectation['name'].toString());
          }).toList();

          List<EvaluationLine> studentEvaluation = (e['evaluation_line_ids'] !=
                  null)
              ? (e['evaluation_line_ids'] as List<dynamic>).map((e) {
                  return EvaluationLine(
                    name: e['name'].toString(),
                    stage: e['stage'] == false ? '' : e['stage'],
                    value: e['value'],
                    pointValue: e['point_value'] == false
                        ? 'no points'
                        : e['point_value'].toString(),
                    race: e['race'] == false ? '' : e['race'],
                    distance: e['distance'] == false ? '0' : e['distance'],
                    lastUpdateDate: e['date'] == false ? 'no date' : e['date'],
                    criteria: e['criteria_id'] != null
                        ? Criteria(
                            name: e['criteria_id']['name'].toString(),
                            order: e['criteria_id']['order'],
                          )
                        : Criteria(),
                  );
                }).toList()
              : [];

          return Evalution(
            evaluationState: e['state'],
            evaluationType: e['evaluation_type'],
            expectations: expectations,
            studentEvaluation: studentEvaluation,
          );
        }).toList();
        return allEvalution;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
    return [];
  }
}
