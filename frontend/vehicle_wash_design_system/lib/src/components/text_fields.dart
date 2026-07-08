import 'package:flutter/material.dart';
import '../theme/typography.dart';
import '../theme/spacing.dart';

class EnterpriseTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? errorText;

  const EnterpriseTextField({
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
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: EnterpriseTypography.labelMedium(theme.colorScheme.onSurface.withOpacity(0.7)),
        ),
        const SizedBox(height: EnterpriseSpacing.base),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: EnterpriseTypography.bodyLarge(theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: EnterpriseTypography.bodyLarge(theme.colorScheme.onSurface.withOpacity(0.4)),
            errorText: errorText,
            filled: true,
            fillColor: theme.colorScheme.surface,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: EnterpriseRadius.smallRadius,
              borderSide: BorderSide(color: theme.colorScheme.primary.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: EnterpriseRadius.smallRadius,
              borderSide: BorderSide(color: theme.colorScheme.primary.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: EnterpriseRadius.smallRadius,
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: EnterpriseRadius.smallRadius,
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }
}
