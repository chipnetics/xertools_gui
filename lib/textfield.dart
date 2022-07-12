import 'package:flutter/material.dart';

class ATextField extends StatefulWidget
{
  ATextField({Key? key}) : super(key:key);

  String? labelText;
  int? maxLines;
  bool readOnly = false;
  var valueText = TextEditingController();

  @override
  State<ATextField> createState() => TextFieldState();
}

class TextFieldState extends State<ATextField>
{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          controller: widget.valueText,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          onSubmitted: (val) =>
              debugPrint('parsed value = $val'),
          onChanged: (String val) {
            final v = int.tryParse(val);
            debugPrint('parsed value = $v');
          },
        )
    );
  }
}