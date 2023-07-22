import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rent_house_app/features/presentation/register/widgets/auth_input_text.dart';
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
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 100.0,
          width: 100.0,
          child: Placeholder(),
        ),
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
                Column(
                  children: [
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
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Image.asset(
                      'assets/google_icon.png',
                      height: 35.0,
                      width: 35.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class PinCodeFields extends StatefulWidget {
  const PinCodeFields({super.key});

  @override
  State<PinCodeFields> createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          pastedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          enabled: isLoading,
          length: 4,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 4) {
              return 'Insira os 4 digitos';
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeColor: Colors.black,
            disabledColor: Colors.white,
            inactiveColor: Colors.black,
            selectedColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.white30,
            activeFillColor:
                hasError ? Colors.white : Colors.white54.withOpacity(0.2),
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          textStyle: TextStyle(
            fontSize: 20,
            height: 1.6,
            color: isLoading ? Colors.white : Colors.black,
          ),
          //backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            setState(() {
              isCompleted = true;
              isLoading = false;
            });
          },

          onChanged: (value) {
            log(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            log("Allowing to paste $text");
            /*
          if (data?.text?.isNotEmpty ?? false) {
                          if (widget.beforeTextPaste != null) {
                            if (widget.beforeTextPaste!(data!.text)) {
                              _showPasteDialog(data.text!);
                            }
                          } else {
                            _showPasteDialog(data!.text!);
                          }
                        }
                        */
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        Visibility(
          visible: !isCompleted,
          replacement: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (!isCompleted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
