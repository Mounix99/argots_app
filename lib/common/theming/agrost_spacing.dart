import 'package:flutter/material.dart';

abstract final class AgrostSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 56;

  // ── SizedBox helpers (vertical) ──────────────────────────────────
  static const SizedBox verticalXxs = SizedBox(height: xxs);
  static const SizedBox verticalXs = SizedBox(height: xs);
  static const SizedBox verticalSm = SizedBox(height: sm);
  static const SizedBox verticalMd = SizedBox(height: md);
  static const SizedBox verticalLg = SizedBox(height: lg);
  static const SizedBox verticalXl = SizedBox(height: xl);
  static const SizedBox verticalXxl = SizedBox(height: xxl);
  static const SizedBox verticalXxxl = SizedBox(height: xxxl);
  static const SizedBox verticalHuge = SizedBox(height: huge);
  static const SizedBox verticalMassive = SizedBox(height: massive);

  // ── SizedBox helpers (horizontal) ────────────────────────────────
  static const SizedBox horizontalXxs = SizedBox(width: xxs);
  static const SizedBox horizontalXs = SizedBox(width: xs);
  static const SizedBox horizontalSm = SizedBox(width: sm);
  static const SizedBox horizontalMd = SizedBox(width: md);
  static const SizedBox horizontalLg = SizedBox(width: lg);
  static const SizedBox horizontalXl = SizedBox(width: xl);
  static const SizedBox horizontalXxl = SizedBox(width: xxl);

  // ── Padding presets ──────────────────────────────────────────────
  static const EdgeInsets screenHorizontal =
      EdgeInsets.symmetric(horizontal: xxl);
  static const EdgeInsets screenAll = EdgeInsets.all(lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(xxl);
  static const EdgeInsets listItemPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);
  static const EdgeInsets inputContentPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);
}

/// Border radii extracted from the Figma design.
///
/// Key measurements from the SVG:
/// - Input fields / form rows: 12px
/// - Small info cards: 12px
/// - Large containers / image cards: 28px
/// - Pill buttons: 27px (fully rounded)
/// - Icon circles: 16-18px
abstract final class AgrostRadii {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;
  static const double pill = 27;
  static const double full = 100;

  static const BorderRadius borderRadiusXs =
      BorderRadius.all(Radius.circular(xs));
  static const BorderRadius borderRadiusSm =
      BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderRadiusMd =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderRadiusLg =
      BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderRadiusXl =
      BorderRadius.all(Radius.circular(xl));
  static const BorderRadius borderRadiusXxl =
      BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius borderRadiusPill =
      BorderRadius.all(Radius.circular(pill));
  static const BorderRadius borderRadiusFull =
      BorderRadius.all(Radius.circular(full));
}

abstract final class AgrostShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
}
