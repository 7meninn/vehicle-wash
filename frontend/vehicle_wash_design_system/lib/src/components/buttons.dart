import 'package:flutter/material.dart';
import '../theme/typography.dart';
import '../theme/spacing.dart';

enum EnterpriseButtonVariant {
  primary,
  secondary,
  ghost,
}

class EnterpriseButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final EnterpriseButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const EnterpriseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = EnterpriseButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.padding,
  });

  @override
  State<EnterpriseButton> createState() => _EnterpriseButtonState();
}

class _EnterpriseButtonState extends State<EnterpriseButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: _getDecoration(theme),
          transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
          transformAlignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(theme)),
                    ),
                  ),
                )
              else if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    widget.icon,
                    size: 18,
                    color: _getTextColor(theme),
                  ),
                ),
              Flexible(
                child: Text(
                  widget.label,
                  style: EnterpriseTypography.labelLarge(_getTextColor(theme)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration(ThemeData theme) {
    switch (widget.variant) {
      case EnterpriseButtonVariant.primary:
        return BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: EnterpriseRadius.pillRadius,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        );
      case EnterpriseButtonVariant.secondary:
        return BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: EnterpriseRadius.pillRadius,
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        );
      case EnterpriseButtonVariant.ghost:
        return BoxDecoration(
          color: _isHovered ? theme.colorScheme.primary.withOpacity(0.05) : Colors.transparent,
          borderRadius: EnterpriseRadius.pillRadius,
        );
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (widget.variant) {
      case EnterpriseButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case EnterpriseButtonVariant.secondary:
      case EnterpriseButtonVariant.ghost:
        return theme.colorScheme.primary;
    }
  }
}
