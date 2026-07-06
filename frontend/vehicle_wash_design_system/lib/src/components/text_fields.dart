import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../theme/spacing.dart';

class VerdantTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? errorText;

  const VerdantTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: VerdantTypography.labelMedium,
        ),
        const SizedBox(height: VerdantSpacing.base),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: VerdantTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: VerdantTypography.bodyLarge.copyWith(
              color: VerdantColors.textSecondary.withOpacity(0.5),
            ),
            errorText: errorText,
            filled: true,
            fillColor: VerdantColors.surfaceElevated,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: VerdantRadius.smallRadius,
              borderSide: const BorderSide(color: VerdantColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: VerdantRadius.smallRadius,
              borderSide: const BorderSide(color: VerdantColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: VerdantRadius.smallRadius,
              borderSide: const BorderSide(color: VerdantColors.warmSand),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: VerdantRadius.smallRadius,
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
