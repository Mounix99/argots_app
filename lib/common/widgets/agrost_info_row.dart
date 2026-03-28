import 'package:flutter/material.dart';
import '../theming/agrost_colors.dart';
import '../theming/agrost_spacing.dart';

class AgrostInfoRow extends StatelessWidget {
  const AgrostInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AgrostSpacing.horizontalSm,
        Expanded(
          child: Text(
            value,
            style: valueStyle ?? theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class AgrostIconInfoRow extends StatelessWidget {
  const AgrostIconInfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconBackgroundColor,
    this.iconColor,
    this.iconRadius = 27,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final double iconRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: iconRadius,
          backgroundColor:
              iconBackgroundColor ?? AgrostColors.surfaceContainer,
          child: Icon(
            icon,
            color: iconColor ?? AgrostColors.textPrimary,
          ),
        ),
        AgrostSpacing.horizontalLg,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              if (subtitle != null) ...[
                AgrostSpacing.verticalXs,
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AgrostColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
