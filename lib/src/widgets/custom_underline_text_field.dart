import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomUnderlineTextField extends HookWidget {
  const CustomUnderlineTextField({
    super.key,
    required this.keyboardType,
    required this.labelText,
    required this.onChanged,
    required this.inputText,
    this.inputFormatters,
  });

  final String labelText;
  final String inputText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xFF727272);
    const focusedTextColor = Color(0xFF97D700);
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode();
    final focusColor = useState(primaryTextColor);

    useEffect(
      () {
        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            focusColor.value = focusedTextColor;
          } else {
            focusColor.value = primaryTextColor;
          }
        });

        if (inputText.isEmpty) {
          textEditingController.text = '';
        }

        return null;
      },
    );

    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      cursorColor: focusColor.value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: focusColor.value),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: focusColor.value,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: focusColor.value,
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Clear Sans',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: primaryTextColor,
      ),
    );
  }
}
