part of 'csa_auth_cubit.dart';

@immutable
abstract class CsaAuthState {}

class PhoneAuthInitial extends CsaAuthState {}

class PhoneAuthLoading extends CsaAuthState {}

class ErrorOccurred extends CsaAuthState {
  final String error;
  ErrorOccurred({required this.error});
}

class PhoneNumberSubmitted extends CsaAuthState {}

class PhoneOtpVerfied extends CsaAuthState {}

class PhoneOtpEnds extends CsaAuthState {}

class UserAuthLoading extends CsaAuthState {}

class UserAuthVerfied extends CsaAuthState {}

class UserLoggedOut extends CsaAuthState {}

class UserResendOtp extends CsaAuthState {}

class CurrentTabProgram extends CsaAuthState {}

class CurrentTabShop extends CsaAuthState {}

class CurrentTab extends CsaAuthState {}

class CleanReadNotification extends CsaAuthState {}

class CurrentLang extends CsaAuthState {
  final Locale locale;
  CurrentLang({required this.locale});
}
