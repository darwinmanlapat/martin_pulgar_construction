import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.height,
    this.isLoading,
    this.isEmpty,
  });

  final String label;
  final void Function()? onPressed;
  final double? height;
  final bool? isLoading;
  final bool? isEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEmpty ?? false
          ? null
          : isLoading ?? false
              ? null
              : onPressed,
      child: SizedBox(
        width: double.infinity,
        height: height ?? 48,
        child: Opacity(
          opacity: isEmpty ?? false
              ? 0.5
              : isLoading ?? false
                  ? 0.5
                  : 1,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0xFF97D700),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE0E0E0),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: isLoading ?? false
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFFFFF),
                      ),
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Clear Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
