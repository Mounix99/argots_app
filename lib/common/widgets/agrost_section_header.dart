import 'package:flutter/material.dart';
import '../theming/agrost_spacing.dart';

class AgrostSectionHeader extends StatelessWidget {
  const AgrostSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
    this.padding,
  });

  final String title;
  final IconData? icon;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: AgrostSpacing.lg),
      child: Row(
        children: [
          Text(title, style: theme.textTheme.displaySmall),
          if (icon != null) ...[
            AgrostSpacing.horizontalSm,
            Icon(icon, size: 20),
          ],
          if (trailing != null) ...[
            const Spacer(),
            trailing!,
          ],
        ],
      ),
    );
  }
}
