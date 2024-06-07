import 'package:csa_app/core/networking/api-constants.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/login/data/user-children.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'csa_auth_state.dart';

class CsaAuthCubit extends Cubit<CsaAuthState> {
  late String verificationId;
  var resendToken;

  CsaAuthCubit() : super(PhoneAuthInitial());
  //CsaAuthCubit() : super(NewNotification(count: 0));

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: false);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException e) {
    emit(ErrorOccurred(error: e.toString()));
    debugPrint(
        '\n Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
  }

  void codeSent(String verificationId, int? resendToken) {
    this.resendToken = resendToken;
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerfied());
    } catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  Future<void> resendOTP(String phoneNumber) async {
    if (resendToken != null) {
      emit(UserResendOtp());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await UserSharedPrefrences().removeUserToken();
    emit(UserLoggedOut());
    emit(PhoneOtpEnds());
  }

  User getLoggedInUser() {
    User user = FirebaseAuth.instance.currentUser!;
    return user;
  }

  //custome api csa

  Future<void> submitUserCredentials(
      String uuid, String phoneNumber, BuildContext context) async {
    emit(UserAuthLoading());
    signInUser(uuid, phoneNumber, context);
  }

  Future<void> signInUser(
      String uuid, String phone, BuildContext context) async {
    try {
      final dio = Dio();
      final fcmToken = await UserSharedPrefrences().getFcmToken();
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.login,
        queryParameters: {
          'uuid': uuid,
          'phone': phone,
          "device_token": fcmToken
        },
      );
      if (response.data['result'] != null) {
        String errorMessage = response.data['result']['error'];
        emit(ErrorOccurred(error: errorMessage.toString()));
      } else {
        List childrenIds = [...response.data["data"]['children_ids']];
        UserProfile userProfile = UserProfile(
          id: response.data["data"]['id'],
          name: response.data["data"]['name'],
          token: response.data["data"]['token'],
          uuid: response.data["data"]['uuid'],
          phone: response.data["data"]['phone'],
          childrenIds: [
            ...childrenIds.map((e) => UserChildren(
                  id: e['id'],
                  name: e['name'],
                ))
          ],
        );
        UserSharedPrefrences().createUser(userProfile);
        emit(UserAuthVerfied());
        // context.pushReplacementNamed(Routes.dashboardScreen,
        //     arguments: userProfile);
      }
    } catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  Future<void> signInUserTest(BuildContext context) async {
    try {
      final dio = Dio();
      emit(UserAuthLoading());
      final response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.login,
        queryParameters: {
          'uuid': "2c7BXDOp1Ca5GeNzhwPOnUczrgI3",
          'phone': "796232324",
          "device_token":
              "eJFw_gNbSGCWMHxbglM5MG:APA91bGQS0ehAY1PU1IbKr4D8jEYQq1Wcui2HWDPSGhTi4nPdF5yjOKVvtNd8tBLf284_lGjsSGsEexmnrpweGEyvZI2E2V9JYPUxy7iBL6rSKgP7EhSvi4mQyi5H2Ehw56mSDTrsyRR"
        },
      );
      if (response.data['result'] != null) {
        String errorMessage = response.data['result']['error'];
        emit(ErrorOccurred(error: errorMessage.toString()));
      } else {
        List childrenIds = [...response.data["data"]['children_ids']];
        UserProfile userProfile = UserProfile(
          id: response.data["data"]['id'],
          name: response.data["data"]['name'],
          token: response.data["data"]['token'],
          uuid: response.data["data"]['uuid'],
          phone: response.data["data"]['phone'],
          childrenIds: [
            ...childrenIds.map((e) => UserChildren(
                  id: e['id'],
                  name: e['name'],
                ))
          ],
        );
        UserSharedPrefrences().createUser(userProfile);
        emit(PhoneOtpVerfied());
        emit(TestUserAuthVerfied());
        // emit(UserAuthVerfied());

        // context.pushReplacementNamed(Routes.dashboardScreen,
        //     arguments: userProfile);
      }
    } catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  Future<UserProfile> getUserDetails() async {
    return UserSharedPrefrences().getUser();
  }

  Future<void> switchLanguage(String langCode) async {
    await UserSharedPrefrences().setlang(langCode);
    emit(CurrentLang(locale: Locale(langCode)));
  }

  Future<void> getSavedLang() async {
    String lang = await UserSharedPrefrences().getlang();
    emit(CurrentLang(locale: Locale(lang)));
  }

  void navigateAllPrograms() {
    emit(CurrentTabProgram());
  }

  void navigateShop() {
    emit(CurrentTabShop());
  }

  void otherCurrentTab() {
    emit(CurrentTab());
  }

  void incrementNotification() {
    UserSharedPrefrences().setNewNotificationState();
  }

  void cleanNotification() {
    UserSharedPrefrences().removeNewNotificationState();
  }
}
