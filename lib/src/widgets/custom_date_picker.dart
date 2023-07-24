import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends HookWidget {
  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
    required this.inputText,
  });

  final void Function(String) onDateSelected;
  final String inputText;

  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xFF727272);
    const focusedTextColor = Color(0xFF97D700);
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode();
    final focusColor = useState(primaryTextColor);
    final selectedDate = useState<DateTime>(DateTime.now());

    Future<void> buildMaterialDatePicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: 'Select Diary Date',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
      );

      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }

    buildCupertinoDatePicker(BuildContext context) {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) {
                  if (picked != selectedDate.value) {
                    selectedDate.value = picked;
                  }
                },
                initialDateTime: selectedDate.value,
                minimumDate: DateTime(2000),
                maximumDate: DateTime.now(),
              ),
            );
          });
    }

    Future<void> selectDate(BuildContext context) async {
      final ThemeData theme = Theme.of(context);
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          return buildMaterialDatePicker(context);
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return buildCupertinoDatePicker(context);
      }
    }

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
          textEditingController.text =
              DateFormat('yyyy-MM-dd').format(DateTime.now());
          selectedDate.value = DateTime.now();
        }

        return null;
      },
    );

    useEffect(
      () {
        textEditingController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate.value);
        onDateSelected(textEditingController.text);
        return null;
      },
      [selectedDate.value],
    );

    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      readOnly: true,
      onTap: () {
        selectDate(context);
      },
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
        labelText: 'Select Date',
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: focusColor.value,
        ),
        suffixIcon: Icon(
          Icons.expand_more,
          color: focusColor.value,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24,
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
