import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lenovo_app/bloc/auth_bloc.dart';
import 'package:lenovo_app/constants/colorConstants.dart';

import 'Otp_screen.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool _secure = false;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _countrycode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _countrycode.text = '+91';
    super.initState();
  }

  bool userNameVerified = false;
  bool loadingIsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserNameVerified) {
          print("dsfsnjnsdfvsdddddddddddddddddddda");

          setState(() {
            userNameVerified = true;
            loadingIsEnabled = false;
          });
          print("dsfsnjnsdfvsdddddddddddddddddddda");
        }
        if (state is AuthInvalidUser) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Username not found')));
        }
      },
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  Phone no..',
                      style: TextStyle(
                          fontSize: 16, color: ColorConstants.greyColor),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: ColorConstants.greyColor),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: _countrycode,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country code ';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                fontSize: 33, color: ColorConstants.greyColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: _phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Number ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                                hintStyle:
                                    TextStyle(color: ColorConstants.greyColor)),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Visibility(
                  visible: userNameVerified,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Password',
                        style: TextStyle(
                            fontSize: 16, color: ColorConstants.greyColor),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ColorConstants.greyColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: _password,
                          obscureText: _secure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Password ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefix: const SizedBox(
                                width: 30,
                              ),
                              border: InputBorder.none,
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
                              hintStyle:
                                  TextStyle(color: ColorConstants.greyColor)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          param: {"un": "${_phone.text}"},
                                        )));
                          },
                          child: const Text(
                            "Login using OTP",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text("Not registered yet ? ",
                        style: TextStyle(fontSize: 15)),
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
                      setState(() {
                        //      loadingIsEnabled = true;
                      });
                      print("dsfsnjna");

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (!userNameVerified) {
                          print("dsfsnjna");
                          Map<String, dynamic> param = {"un": _phone.text};

                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthGenerateOtp(param));
                          print("dsfsnjna");
                        } else {
                          Map<String, dynamic> param = {
                            "un": _phone.text,
                            "pwd": _password.text,
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
      ),
    );
  }
}
