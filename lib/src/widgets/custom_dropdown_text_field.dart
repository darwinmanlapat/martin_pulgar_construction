import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDropdownTextField extends HookWidget {
  const CustomDropdownTextField({
    super.key,
    required this.dropdownItems,
    required this.onItemSelected,
    required this.labelText,
    this.isEnabled = true,
  });

  final List<String> dropdownItems;
  final void Function(String) onItemSelected;
  final String labelText;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xFF727272);
    const focusedTextColor = Color(0xFF97D700);
    final selectedItem = useState<String?>(null);
    final focusColor = useState(primaryTextColor);
    final focusNode = useFocusNode();

    useEffect(() {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          focusColor.value = focusedTextColor;
        } else {
          focusColor.value = primaryTextColor;
        }
      });

      return null;
    });

    return DropdownButtonFormField<String>(
      focusNode: focusNode,
      value: selectedItem.value,
      menuMaxHeight: 300,
      items: dropdownItems.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: primaryTextColor,
            ),
          ),
        );
      }).toList(),
      onChanged: isEnabled == true
          ? (String? newValue) {
              selectedItem.value = newValue;
              onItemSelected(newValue!);
            }
          : null,
      icon: Icon(
        Icons.expand_more,
        color: focusColor.value,
      ),
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
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: primaryTextColor,
        ),
      ),
    );
  }
}
