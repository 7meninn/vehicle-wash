import 'package:flutter/material.dart';
import '../theme/colors.dart';

class VerdantLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const VerdantLoadingIndicator({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? VerdantColors.warmSand,
        ),
      ),
    );
  }
}
