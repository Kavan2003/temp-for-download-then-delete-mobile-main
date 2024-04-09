import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/bloc/auth_bloc.dart';
import 'package:lenovo_app/utils/app_persist.dart';

import '../../constants/colorConstants.dart';
import '../../services/app_functions.dart';
import '../home_page.dart';
import 'Otp_screen.dart';
import 'login2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _secure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final TabController _controller;
  bool userNameVerified = false;
  bool loadingIsEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthLoginLoading) {
              setState(() {
                loadingIsEnabled = true;
              });
            }
            if (state is AuthUserNameVerified) {
              setState(() {
                loadingIsEnabled = false;
                userNameVerified = true;
              });
            }
            if (state is AuthLoginSuccessfully) {
              loadingIsEnabled = false;
              AppFunctions()
                  .toastFun(data: "Login Successfully", positive: true);
              debugPrint("res : ${state.param}");

              log("Finallllllllllll  llll This is \t" "tokken" +
                  AppPersist.getString("token", "N/A"));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
              });
            }
            if (state is AuthInvalidUser) {
              setState(() {
                loadingIsEnabled = false;
              });
              AppFunctions()
                  .toastFun(data: "Invalid Username", positive: false);
            }
            if (state is AuthInvalidPassword) {
              setState(() {
                loadingIsEnabled = false;
              });
              AppFunctions()
                  .toastFun(data: "Invalid Password", positive: false);
            }
          },
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/logo.png'),
                          width: Get.width * 0.25,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 5.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ColorConstants.lightGreyColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TabBar(
                                labelColor: Colors.black,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                controller: _controller,
                                padding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                onTap: (e) {
                                  currentIndex = e;
                                  debugPrint("~~~ index : $e");
                                },
                                tabs: [
                                  SizedBox(
                                      width: Get.width * 0.45,
                                      child: const Tab(
                                        child: Text("E-mail"),
                                      )),
                                  SizedBox(
                                      width: Get.width * 0.45,
                                      child: const Tab(
                                        child: Text("Mobile no"),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              emailLoginWidget(context),
                              const Phone(),
                            ],
                          ),
                        ),
                      ],
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
          )),
    );
  }

  Column emailLoginWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '   E-mail',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email ';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorConstants.greyColor),
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Enter E-mail",
                  hintStyle: TextStyle(color: ColorConstants.greyColor)),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: userNameVerified,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  Password',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _secure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.greyColor),
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(
                      icon: (_secure)
                          ? const Icon(Icons.remove_red_eye_sharp)
                          : const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          _secure = !_secure;
                        });
                      },
                    ),
                    hintText: "Enter Password",
                    hintStyle: TextStyle(color: ColorConstants.greyColor)),
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                param: {'un': emailController.text})));
                  },
                  child: const Text(
                    "Login using OTP",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: userNameVerified ? 20 : 80,
        ),
        const Row(
          children: [
            Text("  Not registered yet ? ", style: TextStyle(fontSize: 15)),
            Text(
              "Request an account",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            )
          ],
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.redColor),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (!userNameVerified) {
                  Map<String, dynamic> param = {"un": emailController.text};

                  BlocProvider.of<AuthBloc>(context)
                      .add(AuthCheckUsername(param));
                } else {
                  Map<String, dynamic> param = {
                    "un": emailController.text,
                    "pwd": passwordController.text,
                  };

                  BlocProvider.of<AuthBloc>(context)
                      .add(AuthPasswordLogin(param));
                }
              }
            },
            child: Text(
              userNameVerified ? 'Login' : 'Check User Name',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
