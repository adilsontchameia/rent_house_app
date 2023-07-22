import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  const InputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.borderEnabled = true,
    this.fontSize = 15.0,
    this.onChanged,
    this.validator,
    required this.controller,
    required this.icon,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool? isVisible;
  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? !isVisible! : false,
          onChanged: widget.onChanged,
          validator: widget.validator,
          cursorColor: Colors.black,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: const Color.fromARGB(255, 55, 55, 55)),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    )),
                width: 10.0,
                child: Icon(widget.icon, color: Colors.white),
              ),
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isVisible = !isVisible!;
                });
              },
              child: Visibility(
                  visible: widget.isPassword ? true : false,
                  child: !isVisible!
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                        )),
            ),
            prefixIconColor: Colors.black,
            filled: true,
            fillColor: Colors.white,
            hintText: widget.label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            labelStyle: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
