import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DiaryFormFieldsContainer extends HookWidget {
  const DiaryFormFieldsContainer({
    super.key,
    required this.child,
    required this.title,
    this.checkboxEnabled = false,
    this.checkboxOnChecked,
  });

  final Widget child;
  final String title;
  final bool? checkboxEnabled;
  final void Function()? checkboxOnChecked;

  @override
  Widget build(BuildContext context) {
    final isChecked = useState(true);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF727272),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (checkboxEnabled == true)
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (_) => const Color(0xFF97D700)),
                        value: isChecked.value,
                        onChanged: (bool? value) {
                          isChecked.value = value!;
                          if (checkboxOnChecked != null) {
                            checkboxOnChecked!();
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            if (isChecked.value) child,
          ],
        ),
      ),
    );
  }
}
