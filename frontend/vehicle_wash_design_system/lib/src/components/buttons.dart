import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../theme/spacing.dart';

enum VerdantButtonVariant {
  primary,
  secondary,
  ghost,
}

class VerdantButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final VerdantButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const VerdantButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = VerdantButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.padding,
  });

  @override
  State<VerdantButton> createState() => _VerdantButtonState();
}

class _VerdantButtonState extends State<VerdantButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: _getDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              else if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    widget.icon,
                    size: 18,
                    color: _getTextColor(),
                  ),
                ),
              Flexible(
                child: Text(
                  widget.label,
                  style: VerdantTypography.labelLarge.copyWith(
                    color: _getTextColor(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.variant) {
      case VerdantButtonVariant.primary:
        return BoxDecoration(
          color: VerdantColors.warmSand,
          borderRadius: VerdantRadius.pillRadius,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: VerdantColors.warmSand.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        );
      case VerdantButtonVariant.secondary:
        return BoxDecoration(
          color: VerdantColors.surfaceElevated,
          borderRadius: VerdantRadius.pillRadius,
          border: Border.all(color: VerdantColors.border),
        );
      case VerdantButtonVariant.ghost:
        return BoxDecoration(
          color: _isHovered ? VerdantColors.whiteTransparent : Colors.transparent,
          borderRadius: VerdantRadius.pillRadius,
        );
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case VerdantButtonVariant.primary:
        return VerdantColors.obsidian;
      case VerdantButtonVariant.secondary:
      case VerdantButtonVariant.ghost:
        return VerdantColors.textPrimary;
    }
  }
}
