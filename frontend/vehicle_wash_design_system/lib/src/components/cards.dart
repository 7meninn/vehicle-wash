import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class VerdantCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const VerdantCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(VerdantSpacing.cardPadding),
    this.borderRadius = VerdantRadius.inner,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: VerdantColors.surface.withOpacity(0.8),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: VerdantColors.border,
                  width: 1.0,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    VerdantColors.whiteTransparent,
                    Colors.transparent,
                  ],
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
