// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../configs/config_components.dart';
import '../configs/config_apps.dart';

class ComponentsInput extends StatefulWidget {
  final TextEditingController? controller;
  final String textTitle;
  final int? maxLength;
  final bool textObscure;
  final bool onlyNumbers;
  final bool onlyCharacters;

  const ComponentsInput({
    required this.controller,
    required this.textTitle,
    required this.textObscure,
    this.onlyNumbers = false,
    this.onlyCharacters = false,
    Key? key,
    this.maxLength,
  }) : super(key: key);

  @override
  _ComponentsInputState createState() => _ComponentsInputState();
}

class _ComponentsInputState extends State<ComponentsInput> {
  bool _textObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultSize * 1.25,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultSize * 0.5,
              ),
              child: ConfigText(
                configFontText: widget.textTitle,
                configFontSize: defaultSize * 0.85,
                configFontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: defaultSize * 0.8),
          TextField(
            controller: widget.controller,
            obscureText: widget.textObscure && _textObscure,
            keyboardType: widget.onlyNumbers
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: colorBlack,
            ),
            maxLength: widget.maxLength ?? 30,
            inputFormatters: [
              if (widget.onlyNumbers)
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              if (widget.onlyCharacters)
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: colorAccent,
              border: kInputBorder,
              errorBorder: eInputBorder,
              focusedBorder: sInputBorder,
              enabledBorder: kInputBorder,
              counterText: '',
              hintText: widget.textTitle != ""
                  ? "Masukan ${widget.textTitle}"
                  : "Type Here . . .",
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                color: colorBlack,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: defaultSize * 1.25,
                horizontal: defaultSize * 1.5,
              ),
              suffixIcon: widget.textObscure
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: defaultSize * 0.5,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _textObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: colorBlack,
                        ),
                        onPressed: () {
                          setState(() {
                            _textObscure = !_textObscure;
                          });
                        },
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: defaultSize * 1.2),
        ],
      ),
    );
  }
}
