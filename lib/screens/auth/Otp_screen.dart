import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/bloc/auth_bloc.dart';
import 'package:lenovo_app/constants/colorConstants.dart';
import 'package:pinput/pinput.dart';

import '../../services/app_functions.dart';
import '../home_page.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic> param;

  const OtpScreen({super.key, required this.param});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinPutController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.transparent),
    ),
  );
  bool loadingIsEnabled = false;

  int _secondsRemaining = 30;
  Timer? _timer;
  Map<String, dynamic> param = {};

  void startTimer() {
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String getFormattedTime(int seconds) {
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthGenerateOtp(widget.param));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      // appBar: AppBar(
      //   backgroundColor: ColorConstants.whiteColor,
      //   title: const Text("OTP"),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _formKey,
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthOtpLoading) {
                    setState(() {
                      loadingIsEnabled = true;
                    });
                  }
                  if (state is OtpSent) {
                    param = state.param;
                    setState(() {
                      loadingIsEnabled = false;
                    });
                    AppFunctions().toastFun(
                        data: "Otp Sent Successfully", positive: true);
                    startTimer();
                  }
                  if (state is OtpVerified) {
                    setState(() {
                      loadingIsEnabled = false;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    });
                  }
                  if (state is AuthInvalidOtp) {
                    setState(() {
                      loadingIsEnabled = false;
                    });
                    AppFunctions()
                        .toastFun(data: "Invalid OTP", positive: false);
                  }
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_outlined)),
                              SizedBox(
                                width: width * 0.3,
                              ),
                              const Text("OTP", style: TextStyle(fontSize: 25)),
                            ],
                          ),
                          const SizedBox(height: 40),
                          const Center(
                              child: Image(
                                  image: AssetImage('assets/images/otp.png'))),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                Get.height * 0.02, 0, 0, Get.height * 0.03),
                            child: const Text(
                              'Verification code',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // wehavesandotpcodeverificationt (37:3928)
                            margin: EdgeInsets.fromLTRB(
                                Get.height * 0.02, 0, 0, Get.height * 0.04),
                            constraints: BoxConstraints(
                              maxWidth: Get.width * 1,
                            ),
                            child: Text(
                              'We have sand  OTP code verification \nto your mobile no ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Get.height * 0.022,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.08,
                                color: const Color(0xff959595),
                              ),
                            ),
                          ),
                          Pinput(
                            controller: pinPutController,
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                border: Border.all(color: Colors.green),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty || e.length != 4) {
                                return "please enter OTP";
                              }
                            },
                            onCompleted: (pin) => debugPrint(pin),
                          ),
                          SizedBox(
                            height: Get.height * 0.07,
                          ),
                          _secondsRemaining > 0
                              ? Text(
                                  "Resend OTP in ${_secondsRemaining > 0 ? getFormattedTime(_secondsRemaining) : "00:00"}",
                                  style: const TextStyle(color: Colors.blue),
                                )
                              : TextButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(AuthGenerateOtp(widget.param));
                                  },
                                  child: const Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.redColor),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (param.isEmpty) {
                                  AppFunctions().toastFun(
                                      data:
                                          "you can't login, please resend OTP",
                                      positive: false);
                                } else {
                                  param['otp'] = pinPutController.text;

                                  Map<String, dynamic> res = {
                                    "refId": param['data']['refId'],
                                    "un": widget.param['un'],
                                    "otp": pinPutController.text.toString(),
                                  };
                                  debugPrint("~param is : $res");
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthOtpLogin(res));
                                }
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const HomePage()));
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loadingIsEnabled,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.redColor,
                  strokeWidth: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
