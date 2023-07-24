import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_house_app/features/presentation/providers/user_provider.dart';
import 'package:rent_house_app/features/presentation/register/widgets/pin_code_fields.dart';
import 'package:rent_house_app/features/presentation/widgets/custom_input_text.dart';
import 'package:rent_house_app/features/services/auth_service.dart';
import 'package:rent_house_app/helpers/validator_mixin.dart';

import 'widgets/location_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixins {
  //? Global key for validation purpose
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  //? Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentLocationController =
      TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();
  XFile? _image;

  Future<void> _submit() async {
    final validationPassed = _formKey.currentState!.validate();
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text.trim();
    //final String otpCode = otpCodeController.text.trim();
    final String address = currentLocationController.text.trim();

    //TODO do not need email will use number and Google
    if (validationPassed && _image != null) {
      setState(() {
        //_showDialogBox();
        _userAuthProvider.isReady = true;
        _userAuthProvider.signUp(
          name: '$firstName $lastName',
          email: email,
          phone: phone,
          image: _image!,
          address: address,
          password: password,
        );
      });
    } else {
      _showDialogBox();
    }
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
          SafeArea(
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await _showImageDialogBox();
                },
                child: SizedBox(
                    height: 90.0,
                    width: 90.0,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Center(
                        child: _image == null
                            ? Image.asset('assets/person.png',
                                fit: BoxFit.cover)
                            : Image.file(File(_image!.path),
                                fit: BoxFit.cover), //After pick image
                      ),
                    )),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
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
                      icon: Icons.email,
                      isPassword: false,
                      keyboardType: TextInputType.name,
                      controller: emailController,
                      label: 'Email',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.phone,
                      isPassword: false,
                      controller: phoneController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Número de Phone',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    InputText(
                      icon: Icons.password,
                      isPassword: true,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Senha',
                      fontSize: 15.0,
                      validator: (value) => insNotEmpty(value),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'OBS: Aperte no ícone de gps para buscar sua localização atual.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    LocationInputText(
                      icon: Icons.location_on,
                      controller: currentLocationController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Sua Localização Atual',
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
                      'Ou clicque abaico e entre com sua conta Google',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () => AuthService().signInWithGoogle(),
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

  Future<void> _showImageDialogBox() async {
    final authData = Provider.of<UserAuthProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Carregar imagem de perfil.',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () => authData.getGalleryImage().then((image) {
                      setState(() {
                        _image = image;
                      });
                    }),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Galeria',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    //color: Colors.pinkAccent,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Câmera',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => authData.getCameraImage().then((image) {
                      setState(() {
                        _image = image;
                      });
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
