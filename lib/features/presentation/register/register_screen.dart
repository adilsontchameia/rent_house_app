import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rent_house_app/features/presentation/register/widgets/pin_code_fields.dart';
import 'package:rent_house_app/features/presentation/widgets/app_logo.dart';
import 'package:rent_house_app/features/presentation/widgets/custom_input_text.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();

  Future<void> _submit() async {
    _showDialogBox();
    /*
    final validationPassed = _formKey.currentState!.validate();
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String password = passwordController.text.trim();
    final String otpCode = otpCodeController.text.trim();
    if (validationPassed) {
      // _userManagerProvider.login(email, password);
    }
    */
  }

  Future<void> _showDialogBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
          content: SingleChildScrollView(
            child: PinCodeFields(
              textEditingController: otpCodeController,
            ),
          ),
        );
      },
    );
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
            top: MediaQuery.of(context).size.height * 0.10,
            left: 50.0,
            right: 50.0,
            child: const AppLogo(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
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
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      label: 'Nome',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.person_3,
                      isPassword: false,
                      keyboardType: TextInputType.name,
                      controller: lastNameController,
                      label: 'Sobrenome',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.phone,
                      isPassword: false,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Número de Phone',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.phone,
                      isPassword: true,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Senha',
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
                          'Cadastrar',
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
                      'Ou clicque abaico e registre-se com sua conta Google',
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
                      'Já tenho uma conta.',
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
