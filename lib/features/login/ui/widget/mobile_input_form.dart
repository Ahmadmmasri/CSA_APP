import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/Loading.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/features/login/ui/widget/custome_button.dart';
import 'package:csa_app/features/login/ui/widget/fail-login-dialog.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MobileInputForm extends StatefulWidget {
  const MobileInputForm({super.key});

  @override
  State<MobileInputForm> createState() => _MobileInputFormState();
}

class _MobileInputFormState extends State<MobileInputForm> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String initialCountry = 'JO';
  String inputValue = '';
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<CsaAuthCubit, CsaAuthState>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Loading();
            },
          );
        }
        if (state is PhoneNumberSubmitted) {
          context.pop();
          context.pushNamed(Routes.otpScreen, arguments: inputValue);
        }
        if (state is TestUserAuthVerfied) {
          context.pushReplacementNamed(
            Routes.dashboardScreen,
          );
        }
        if (state is ErrorOccurred) {
          context.pop();
          // String errorMessage = state.error;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const FailLoginDialog();
            },
          );
        }
      },
      child: Container(),
    );
  }

  Future<void> _register(String phoneNumber) async {
    if (phoneNumber == "+962796232324") {
      BlocProvider.of<CsaAuthCubit>(context).signInUserTest(context);
    } else {
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        formKey.currentState?.save();
        BlocProvider.of<CsaAuthCubit>(context).submitPhoneNumber(
          phoneNumber,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String? phoneValidator(value) {
      if (value!.length < 11) {
        return S.of(context).invalidNumberTitle;
      }
      return null;
    }

    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.025, vertical: 10.0),
            child: Form(
              key: formKey,
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  inputValue = number.phoneNumber.toString();
                },
                onInputValidated: (bool value) {
                  debugPrint(value.toString());
                },
                validator: phoneValidator,
                initialValue: PhoneNumber(isoCode: 'JO'),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                spaceBetweenSelectorAndTextField: 20,
                selectorTextStyle: const TextStyle(
                  color: ColorsManager.black,
                ),
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useEmoji: false,
                  leadingPadding: 15,
                  useBottomSheetSafeArea: false,
                  trailingSpace: true,
                  setSelectorButtonAsPrefixIcon: true,
                ),
                textFieldController: controller,
                formatInput: true,
                maxLength: 11,
                cursorColor: ColorsManager.primary,
                textStyle: TextStyle(
                  color: ColorsManager.primary.withOpacity(0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorsManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                autoFocus: true,
                onSaved: (PhoneNumber number) {
                  // debugPrint('On Saved: $number');
                },
              ),
            ),
            // Stack(children: [
            // Positioned(
            //   child: Container(
            //     width: 104.w,
            //     height: 48.h,
            //     decoration: BoxDecoration(
            //       color: ColorsManager.periwinkle,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.shade300,
            //           blurRadius: 3,
            //           offset: const Offset(0, 2),
            //         )
            //       ],
            //       // borderRadius: BorderRadius.circular(8),
            //       border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     child: Container(),
            //   ),
            // ),
            // Positioned(
            //   child:
            // ),
            //]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomeButton(
              buttonTitle: S.of(context).loginHeaderScreenTitle,
              onPress: () async {
                _register(inputValue);
              },
              background: ColorsManager.primary,
              borderColor: ColorsManager.primary,
              fontColor: ColorsManager.white,
            ),
          ),
          _buildPhoneNumberSubmitedBloc(),
        ],
      ),
    );
  }
}
