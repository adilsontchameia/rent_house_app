import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_house_app/features/presentation/providers/user_provider.dart';

class LocationInputText extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final double width;
  const LocationInputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.borderEnabled = true,
    this.fontSize = 15.0,
    this.onChanged,
    this.validator,
    this.width = 0,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  State<LocationInputText> createState() => _LocationInputTextState();
}

class _LocationInputTextState extends State<LocationInputText> {
  @override
  Widget build(BuildContext context) {
    final geolocatorProvider = Provider.of<UserAuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: widget.width == 0
            ? MediaQuery.of(context).size.width * 0.85
            : widget.width,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
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
                  widget.controller.text = 'Procurando, Por Favor, Aguarde.';
                  geolocatorProvider.getCurrentLocation().then((_) {
                    try {
                      return widget.controller.text =
                          geolocatorProvider.userAddress;
                    } catch (e) {
                      return ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        duration: Duration(seconds: 4),
                        content: Text(
                          'Não foi possivel determinar sua localização, por favor, tente novamente.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        backgroundColor: Colors.black,
                      ));
                    }
                  });
                  widget.controller.text = 'Procurando';
                },
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.black,
                )),
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
