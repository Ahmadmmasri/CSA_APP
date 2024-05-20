import 'dart:convert';
import 'dart:ui';

import 'package:csa_app/features/login/data/user-children.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csa_app/core/helpers/constant.dart' as constant;

class UserSharedPrefrences {
  Future<bool> _setUser(UserProfile userProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", userProfile.id!);
    prefs.setString("name", userProfile.name!);
    prefs.setBool("email", userProfile.uuid!);
    prefs.setString("phone", userProfile.phone!);
    prefs.setString(
        "childrenIds",
        userProfile.childrenIds == null
            ? "[]"
            : jsonEncode(
                userProfile.childrenIds!.map((e) => e.toJson()).toList()));

    constant.storage.write(key: "token", value: userProfile.token!);
    return prefs.commit();
  }

  void createUser(UserProfile userProfile) async {
    _setUser(userProfile);
  }

  Future<UserProfile> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? childrenIdsJson = prefs.getString("childrenIds");
    List<UserChildren> childrenIds = [];

    if (childrenIdsJson != null && childrenIdsJson.isNotEmpty) {
      List<dynamic> decodedList = jsonDecode(childrenIdsJson);
      childrenIds = decodedList.map((e) => UserChildren.fromJson(e)).toList();
    }
    return UserProfile(
      id: prefs.getInt("id"),
      name: prefs.getString("name"),
      uuid: prefs.getBool("email"),
      phone: prefs.getString("phone"),
      childrenIds: childrenIds,
      token: await constant.storage.read(key: "token"),
    );
  }

  Future<void> removeUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove("childrenIds");
    await constant.storage.deleteAll();
  }

  Future<String> getToken() async {
    String? token = await constant.storage.read(key: "token");
    // return token ?? "79d8b0b4-5a35-4e1e-8787-2e20926c43c0";

    return token ?? "";
  }

  Future<String> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  Future<void> setlang(String langCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Locale', langCode);
  }

  Future<String> getlang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale deviceLocale = window.locale; // or html.window.locale
    String deviceLangCode = deviceLocale.languageCode;
    return prefs.getString('Locale') ?? deviceLangCode;
  }

  Future<void> sethideIndecator() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hideIndecator', true);
  }

  Future<bool> getIndecatorState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hideIndecator') ?? false;
  }

  Future<void> setNewNotificationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSavedbefore = prefs.getBool('hasNotSeen') ?? false;
    if (!isSavedbefore) {
      prefs.setBool('hasNotSeen', true);
    }
  }

  Future<bool> getNewNotificationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasNotSeen') ?? false;
  }

  Future<void> removeNewNotificationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("hasNotSeen");
  }
}
