import 'dart:convert';
import 'package:csa_app/core/networking/api-constants.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/about.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/contact.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/terms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MoreController {
  Future<About> fetchAboutCsa() async {
    var dio = Dio();
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getAbout);
      if (response.statusCode == 200) {
        List allData = [...response.data["data"]];

        About aboutData = About(
          name: allData[0]['name'] ?? "",
          description: allData[0]['description'].toString() == "false"
              ? "No Data Found"
              : allData[0]['description'].toString(),
          imgUrl: allData[0]['image'].toString() == "false"
              ? ""
              : allData[0]['image'].toString(),
        );
        return aboutData;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return About(name: "", description: "", imgUrl: "");
  }

  Future<Terms> fetchTerms(int id) async {
    var dio = Dio();
    try {
      Response response = id == 0
          ? await dio.get(ApiConstants.baseUrl + ApiConstants.getTerms)
          : await dio.get(ApiConstants.baseUrl + ApiConstants.getPolicy);

      if (response.statusCode == 200) {
        List allData = [...response.data["data"]];

        Terms termsData = Terms(
            name: allData[0]['name'] ?? "",
            heade: id == 0 ? 'Terms and Conditions' : "Privacy Policy");
        return termsData;
      } else {
        debugPrint(response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return Terms(name: "");
  }

  Future<List<Contact>> fetchContactInfo() async {
    var dio = Dio();
    try {
      Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.getContact);

      if (response.statusCode == 200) {
        List allData = [...response.data["data"]];
        List<Contact> contacts = [];

        for (var data in allData) {
          Contact contact = Contact(
            title: data['title'] == false ? "" : data['title'],
            subTitle: data['name'] == false ? "" : data['name'],
            image: data['image'] == false
                ? Uint8List(0)
                : base64.decode(
                    data['image'],
                  ),
            phoneNumber: data['phone'] == false ? "" : data['phone'],
            location: data['location'] == false ? "" : data['location'],
          );
          contacts.add(contact);
        }

        return contacts;
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
}
