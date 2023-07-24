import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/providers/user_provider.dart';
import 'package:rent_house_app/features/presentation/widgets/app_logo.dart';
import 'package:rent_house_app/features/presentation/widgets/custom_input_text.dart';
import 'package:rent_house_app/helpers/validator_mixin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with ValidationMixins {
  //? Global key for validation purpose
  final GlobalKey<FormState> _formKey = GlobalKey();

  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  //? Controllers
  final TextEditingController phoneNumberOrEmailController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _submit() async {
    final validationPassed = _formKey.currentState!.validate();
    final String phoneOrEmail = phoneNumberOrEmailController.text.trim();
    final String password = passwordController.text.trim();

    //Validating before login
    if (validationPassed) {
      _userAuthProvider.login(phoneOrEmail, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 50.0,
            right: 50.0,
            child: const AppLogo(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40,
            left: 10.0,
            right: 10.0,
            child: Form(
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
                      controller: phoneNumberOrEmailController,
                      keyboardType: TextInputType.name,
                      label: 'Nome ou Email',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.person_3,
                      isPassword: true,
                      keyboardType: TextInputType.name,
                      controller: passwordController,
                      label: 'Senha',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    const SizedBox(height: 10.0),
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
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        //color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'É novo ? Clique aqui para se cadastrar.',
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
          )
        ],
      ),
    ));
  }
}
