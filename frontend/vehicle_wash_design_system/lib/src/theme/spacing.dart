import 'package:flutter/material.dart';

class VerdantSpacing {
  static const double base = 8.0;
  static const double gap = 16.0;
  static const double cardPadding = 24.0;
  static const double sectionPadding = 80.0;
  
  // Helpers
  static const SizedBox spaceBase = SizedBox(width: base, height: base);
  static const SizedBox spaceGap = SizedBox(width: gap, height: gap);
  static const SizedBox spaceCardPadding = SizedBox(width: cardPadding, height: cardPadding);
}

class VerdantRadius {
  static const double small = 8.0; // from YAML card
  static const double inner = 16.0; // 1rem for inner UI
  static const double major = 32.0; // 2rem for major containers
  static const double pill = 9999.0;
  
  static final BorderRadius smallRadius = BorderRadius.circular(small);
  static final BorderRadius innerRadius = BorderRadius.circular(inner);
  static final BorderRadius majorRadius = BorderRadius.circular(major);
  static final BorderRadius pillRadius = BorderRadius.circular(pill);
}
