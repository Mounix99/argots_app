import 'package:flutter/material.dart';
import '../theming/agrost_colors.dart';
import '../theming/agrost_spacing.dart';

class AgrostEmptyState extends StatelessWidget {
  const AgrostEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: AgrostSpacing.screenHorizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AgrostColors.textTertiary,
            ),
            AgrostSpacing.verticalXl,
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              AgrostSpacing.verticalSm,
              Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AgrostColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              AgrostSpacing.verticalXxl,
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
