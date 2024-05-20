import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/Loading.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/features/login/ui/widget/custome_button.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String otpCode;
  bool isResendClicked = false;

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<CsaAuthCubit, CsaAuthState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) async {
        if (state is PhoneAuthLoading ||
            state is UserAuthLoading ||
            state is UserResendOtp) {
          const Loading();
        }
        if (state is UserAuthVerfied &&
            state is! UserLoggedOut &&
            state is! PhoneOtpEnds) {
          context.pop();
          context.pushReplacementNamed(
            Routes.dashboardScreen,
          );
        }
        if (state is ErrorOccurred) {
          String errorMessage = state.error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              closeIconColor: Colors.white,
              content: Text(errorMessage),
              backgroundColor: ColorsManager.primary,
              duration: const Duration(seconds: 15),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _login(BuildContext context) {
    // String uid = context.read<PhoneAuthCubit>().getLoggedInUser().uid;
    BlocProvider.of<CsaAuthCubit>(context).submitOtp(otpCode).then((value) => {
          BlocProvider.of<CsaAuthCubit>(context).submitUserCredentials(
            context.read<CsaAuthCubit>().getLoggedInUser().uid,
            widget.phoneNumber.substring(4),
            context,
          ),
        });
  }

  void resendOtp(BuildContext context) {
    // String uid = context.read<PhoneAuthCubit>().getLoggedInUser().uid;
    BlocProvider.of<CsaAuthCubit>(context)
        .resendOTP(widget.phoneNumber)
        .then((value) => {
              setState(() {
                isResendClicked = true;
              }),
              const SnackBar(
                content: Text("Otp sent successfully"),
                backgroundColor: ColorsManager.primary,
                duration: Duration(seconds: 3),
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              S.of(context).otpScreenTitle + widget.phoneNumber,
              style: TextStyles.font22MagentaW500Weight
                  .copyWith(color: ColorsManager.primary),
            ),
          ),
          verticalSpace(40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: PinCodeTextField(
              appContext: context,
              autoFocus: true,
              cursorColor: ColorsManager.primary,
              textStyle:
                  TextStyles.font16BoldWeight.copyWith(color: Colors.white),
              keyboardType: TextInputType.number,
              length: 6,
              obscureText: false,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                borderWidth: 1,
                activeColor: ColorsManager.primary,
                inactiveColor: Colors.grey,
                inactiveFillColor: Colors.white,
                activeFillColor: ColorsManager.primary,
                selectedColor: ColorsManager.lightBlue,
                selectedFillColor: Colors.white,
                errorBorderColor: ColorsManager.darkRed,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              onCompleted: (submitedCode) {
                otpCode = submitedCode;
              },
              onChanged: (value) {
                otpCode = value;
              },
            ),
          ),
          verticalSpace(8),
          TextButton(
            onPressed: () {
              resendOtp(context);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: isResendClicked
                        ? Colors.grey.shade300
                        : ColorsManager.primary,
                  ),
                ),
              ),
            ),
            child: Text(
              S.of(context).resendOTPButton,
              style: TextStyles.font14RegularWeight.copyWith(
                color:
                    isResendClicked ? Colors.grey[300] : ColorsManager.primary,
              ),
            ),
          ),
          verticalSpace(40),
          CustomeButton(
            buttonTitle: S.of(context).otpScreenSendButton,
            onPress: () {
              if (otpCode.length == 6) {
                _login(context);
              }
            },
            background: ColorsManager.primary,
            borderColor: ColorsManager.primary,
            fontColor: ColorsManager.white,
          ),
          _buildPhoneVerificationBloc(),
        ],
      ),
    );
  }
}
