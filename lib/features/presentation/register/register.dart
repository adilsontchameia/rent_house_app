import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/register/widgets/app_logo.dart';
import 'package:rent_house_app/features/presentation/register/widgets/auth_input_text.dart';
import 'package:rent_house_app/features/presentation/register/widgets/pin_code_fields.dart';
import 'package:rent_house_app/helpers/validator_mixin.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixins {
  //? Global key for validation purpose
  final GlobalKey<FormState> _formKey = GlobalKey();
  //? Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _submit() async {
    _showDialogBox();
    /*
    final validationPassed = _formKey.currentState!.validate();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    if (validationPassed) {
      // _userManagerProvider.login(email, password);
    }
    */
  }

  Future<void> _showDialogBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Por favor, insira o  código de confirmação enviado.',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          content: const SingleChildScrollView(
            child: PinCodeFields(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 0,
          left: -65,
          child: Transform.rotate(
            angle: 180.0,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.0),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -65,
          child: Transform.rotate(
            angle: 180.0,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(90.0),
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppLogo(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InputText(
                      icon: Icons.person,
                      isPassword: false,
                      controller: emailController,
                      keyboardType: TextInputType.name,
                      label: 'First Name',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.person_3,
                      isPassword: false,
                      keyboardType: TextInputType.name,
                      controller: passwordController,
                      label: 'Last Name',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.phone,
                      isPassword: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Phone Number',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sign-up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        //color: Colors.pinkAccent,
                      ),
                    ),
                    const Text(
                      'Or tap below to sign-up with Google',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () => log('Google'),
                      child: Image.asset(
                        'assets/google_icon.png',
                        height: 35.0,
                        width: 35.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'I already have an account.',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 2,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
