import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String verify='';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();


class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  var phone;

  final LoginController controller = Get.put(LoginController());


  @override
  void dispose() {
    phoneController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String countryCode = '+91';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('TyrePlex Ops'),
        centerTitle: true,
      ),

      body: SafeArea(
          child: Column(

            children: [
              SizedBox(height: 10.h,),
              Text('Enter 10 digit mobile number',
              style:const TextStyle(
                fontSize: 20,
                letterSpacing: 0.5,
              ) ,
              ),
              SizedBox(height: 2.h,),

              Text('An OTP will be sent to this mobile number',
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.5,
                  color: Colors.grey[600]
                ) ,
              ),
              SizedBox(height: 5.h,),
              Form(
                key: _formKey ,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneController,
                        onChanged: (value) {
                          phone = value;
                        },
                        autofocus: true,
                        cursorColor: Colors.red,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(value == null || value.isEmpty || value.length>10 ||value.length<10) {
                            return 'Enter the correct mobile number';
                          }
                           return null;
                        },

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.red,
                          labelText: 'Mobile Number',
                          labelStyle:  const TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            // color: Colors.grey[800],
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.8),
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black,),
                          ),
                        ),
                      ),
                  SizedBox(height: 5.h,),

                    ],
                  ),

                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: ElevatedButton(
                    onPressed: () async {
                        if(_formKey.currentState!.validate()) {

                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countryCode + phone}',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              final snackbar = SnackBar(content: Text(e.code));
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              LoginScreen.verify = verificationId;
                              // Navigator.pushNamed(context, OtpRoute);
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                          Navigator.pushNamed(context, OtpRoute, arguments: phoneController.text);
                       }
                         //Navigator.pushNamed(context, OtpRoute, arguments: phoneController.text);
                    },

                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                      child: Text(
                        'Submit',
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
