import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/screens/RFResetPasswordScreen.dart';
import 'package:room_finder_flutter/screens/RFSignUpScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFString.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/codePicker/country_code_picker.dart';

import 'RFHomeScreen.dart';

class RFMobileSignIn extends StatefulWidget {
  @override
  _RFMobileSignInState createState() => _RFMobileSignInState();
}

class _RFMobileSignInState extends State<RFMobileSignIn> {
  String dialCodeDigits = '+84';
  String phoneNumber = '';
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String _verificationId = '';
  bool statusBtn = false;

  @override
  void initState() {
    super.initState();
    init();
    // verifyPhoneNum();
  }

  void init() async {
    // setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    changeStatusColor(appStore.scaffoldBackground!);
    super.dispose();
  }

  // verifyPhoneNumber() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '${this.dialCodeDigits + this.phoneNumber}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await FirebaseAuth.instance
  //           .signInWithCredential(credential)
  //           .then((value) {
  //         if (value.user != null) {
  //           RFHomeScreen().launch(context);
  //         }
  //       });
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(e.message.toString()),
  //         duration: Duration(seconds: 3),
  //       ));
  //     },
  //     codeSent: (String vID, int? resentToken) {
  //       setState(() {
  //         verificationID = vID;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String vID) {
  //       setState(() {
  //         verificationID = vID;
  //       });
  //     },
  //     timeout: Duration(seconds: 60),
  //   );
  // }

  sentOTP() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${this.dialCodeDigits + phoneController.text}',
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
          // await FirebaseAuth.instance.signInWithCredential(credential);
          // Navigator.of(context).pushReplacementNamed('/home');
          print(
              'Phone number automatically verified and user signed in: ${FirebaseAuth.instance.currentUser?.uid}');
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}. Phone number: ${phoneNumber}');
        },
        codeSent: (verificationId, [forceResendingToken]) {
          print('Please check your phone for the verification code.');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print("verification code: " + verificationId);
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print("Failed to Verify Phone Number: ${e}");
    }
  }

  verifyPhoneNum() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otpController.text,
    );
    await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    RFHomeScreen().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RFCommonAppComponent(
          title: RFAppName,
          subTitle: RFAppSubTitle,
          cardWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mobile Number', style: boldTextStyle(size: 18)),
              16.height,
              Text(
                'Please enter your phone number. We will send you 4-digit code to verify your account.',
                style: primaryTextStyle(),
                maxLines: 4,
                textAlign: TextAlign.center,
              ).flexible(),
              16.height,
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: boxDecoration(
                    showShadow: false,
                    bgColor: context.cardColor,
                    radius: 8,
                    color: context.dividerColor),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CountryCodePicker(
                        onChanged: (country) {
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          });
                        },
                        initialSelection: 'VN',
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: ['+1', 'US'],
                        padding: EdgeInsets.all(0),
                        showFlag: false),
                    Container(
                      height: 25.0,
                      width: 1.0,
                      color: context.dividerColor,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Phone Number"),
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ).expand(),
                  ],
                ),
              ),
              16.height,
              AppTextField(
                controller: otpController,
                textFieldType: TextFieldType.NUMBER,
                decoration: rfInputDecoration(
                  lableText: "OTP",
                  showLableText: true,
                  suffixIcon: Container(
                    padding: EdgeInsets.all(2),
                    decoration: boxDecorationWithRoundedCorners(
                        boxShape: BoxShape.circle,
                        backgroundColor: rf_rattingBgColor),
                    child: Icon(Icons.done, color: Colors.white, size: 14),
                  ),
                ),
              ),
              24.height,
              AppButton(
                color: rf_primaryColor,
                child: Text('Gửi OTP', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  // if (statusBtn) {

                  // } else {
                  // }
                  sentOTP();
                  // RFEmailSignInScreen().launch(context);
                },
              ),
              24.height,
              AppButton(
                color: rf_primaryColor,
                child: Text('Đăng nhập', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () async {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: _verificationId,
                    smsCode: otpController.text,
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  RFHomeScreen().launch(context);
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    child: Text("Reset Password?", style: primaryTextStyle()),
                    onPressed: () {
                      RFResetPasswordScreen().launch(context);
                    }),
              ),
            ],
          ),
          subWidget: socialLoginWidget(
            context,
            title1: "New Member? ",
            title2: "Sign up Here",
            callBack: () {
              RFSignUpScreen().launch(context);
            },
          ),
        ),
      ),
    );
  }
}
