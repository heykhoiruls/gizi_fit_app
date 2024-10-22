import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsInputText extends StatefulWidget {
  final String? textHint;
  final TextEditingController? controller;
  final ValueChanged<bool>? onFocusChange;
  final Function(String)? onSearch;

  const ComponentsInputText({
    Key? key,
    this.textHint,
    this.onFocusChange,
    this.controller,
    this.onSearch,
  }) : super(key: key);

  @override
  State<ComponentsInputText> createState() => _ComponentsInputTextState();
}

bool _isFocused = false;

class _ComponentsInputTextState extends State<ComponentsInputText> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    widget.onFocusChange?.call(_isFocused);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Focus(
        onFocusChange: (hasFocus) {
          _onFocusChange();
        },
        child: TextField(
          onChanged: (value) {
            widget.onSearch?.call(value);
          },
          focusNode: _focusNode,
          style: GoogleFonts.poppins(
            color: colorBlack,
          ),
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: colorAccent,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: defaultSize * 1.5,
              vertical: defaultSize,
            ),
            hintStyle: const TextStyle(color: colorBlack),
            hintText: widget.textHint ?? "Type here . . .",
            border: sInputBorder,
            errorBorder: sInputBorder,
            focusedBorder: sInputBorder,
            enabledBorder: sInputBorder,
          ),
        ),
      ),
    );
  }
}
