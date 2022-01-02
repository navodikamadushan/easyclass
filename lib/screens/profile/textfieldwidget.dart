// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/shared/constant.dart";
//import 'package:shared_preferences/shared_preferences.dart';

class TextFieldWidget extends StatefulWidget {
  final String hint;
  final String invaliderror;
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    this.hint = '',
    this.invaliderror,
    this.maxLines = 1,
    this.label,
    this.text,
    this.onChanged,
  });

  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: widget.maxLines,
            decoration: textInputDecoration.copyWith(hintText: widget.hint),
            validator: (val) => val.isEmpty ? widget.invaliderror : null,
            onChanged: widget.onChanged,
          ),
        ],
      );
}
