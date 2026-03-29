import 'package:flutter/material.dart';
import 'agrost_colors.dart';

class AgrostSemanticColors extends ThemeExtension<AgrostSemanticColors> {
  const AgrostSemanticColors({
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.info,
    required this.infoContainer,
    required this.divider,
    required this.cardBackground,
    required this.inputBackground,
    required this.inputBorder,
    required this.errorBorder,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color info;
  final Color infoContainer;
  final Color divider;
  final Color cardBackground;
  final Color inputBackground;
  final Color inputBorder;
  final Color errorBorder;
  final Color shimmerBase;
  final Color shimmerHighlight;

  static const light = AgrostSemanticColors(
    success: AgrostColors.success,
    successContainer: AgrostColors.successContainer,
    warning: AgrostColors.warningDark,
    warningContainer: AgrostColors.warning,
    info: AgrostColors.info,
    infoContainer: AgrostColors.infoContainer,
    divider: AgrostColors.divider,
    cardBackground: AgrostColors.surfaceContainer,
    inputBackground: AgrostColors.white,
    inputBorder: AgrostColors.border,
    errorBorder: AgrostColors.error,
    shimmerBase: AgrostColors.grey100,
    shimmerHighlight: AgrostColors.grey50,
  );

  static const dark = AgrostSemanticColors(
    success: AgrostColors.primaryBright,
    successContainer: Color(0xFF1E3620),
    warning: AgrostColors.warning,
    warningContainer: Color(0xFF3E2800),
    info: Color(0xFF64B5F6),
    infoContainer: Color(0xFF002E5C),
    divider: AgrostColors.dividerDark,
    cardBackground: AgrostColors.surfaceContainerDark,
    inputBackground: AgrostColors.surfaceContainerDark,
    inputBorder: AgrostColors.borderDark,
    errorBorder: AgrostColors.error,
    shimmerBase: AgrostColors.grey600,
    shimmerHighlight: AgrostColors.grey700,
  );

  @override
  AgrostSemanticColors copyWith({
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? info,
    Color? infoContainer,
    Color? divider,
    Color? cardBackground,
    Color? inputBackground,
    Color? inputBorder,
    Color? errorBorder,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AgrostSemanticColors(
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      divider: divider ?? this.divider,
      cardBackground: cardBackground ?? this.cardBackground,
      inputBackground: inputBackground ?? this.inputBackground,
      inputBorder: inputBorder ?? this.inputBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  AgrostSemanticColors lerp(AgrostSemanticColors? other, double t) {
    if (other is! AgrostSemanticColors) return this;
    return AgrostSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      errorBorder: Color.lerp(errorBorder, other.errorBorder, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}
