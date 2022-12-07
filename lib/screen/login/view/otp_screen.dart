import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ops/screen/login/view/login_screen.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);
  final String mobileNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verification = LoginScreen.verify;

  verifyOtp(String code) async {
   final String Code = code;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginScreen.verify, smsCode: Code);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreenRoute,
          arguments: widget.mobileNumber,
          (route) => false);
    } catch (e) {
      // print(e);
      const snackbar = SnackBar(content: Text('Enter a valid OTP'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void requestCodeAgain(String code, String number) async {
    String countryCode = code;
    String mobileNumber = number;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${countryCode + mobileNumber}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verification = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var code = '';
    String countryCode = '+91';
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('TyrePlex Ops'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
              width: 100.w,
            ),
            const Text(
              'Verify Phone',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                'Code is sent to ${widget.mobileNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Pinput(
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
                length: 6,
                onChanged: (value) {
                  code = value;

                  if ((RegExp(r'^[0-9]{6}$').hasMatch(value))) {
                    verifyOtp(code);
                  }
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Didn\'t receive the code?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff6A6C7B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    requestCodeAgain(countryCode, widget.mobileNumber);
                  },
                  child: const Text(
                    'Request Again',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: ElevatedButton(
                onPressed: () async {
                  verifyOtp(code);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  child: Text(
                    'Verify and Continue',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 16,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
