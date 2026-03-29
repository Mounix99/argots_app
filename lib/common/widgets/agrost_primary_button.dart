import 'package:flutter/material.dart';
import '../theming/agrost_colors.dart';
import '../theming/agrost_spacing.dart';
import 'agrost_loading_indicator.dart';

/// Dark pill button with lime green text/icon.
/// Matches Figma: #191B1D fill, rx=27, 54px tall.
class AgrostPrimaryButton extends StatelessWidget {
  const AgrostPrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Widget? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const AgrostLoadingIndicator(color: AgrostColors.primary)
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  AgrostSpacing.horizontalSm,
                  Text(label),
                ],
              )
            : Text(label);

    final button = FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    return expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Lime green pill button with dark text.
/// Matches Figma: #DBFB9A fill, rx=27, 54px tall.
class AgrostSecondaryButton extends StatelessWidget {
  const AgrostSecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Widget? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const AgrostLoadingIndicator(color: AgrostColors.textPrimary)
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  AgrostSpacing.horizontalSm,
                  Text(label),
                ],
              )
            : Text(label);

    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    return expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Bordered input-style row that matches Figma form fields.
/// White fill, #E6EAED border, rx=12, 55px tall.
class AgrostFormField extends StatelessWidget {
  const AgrostFormField({
    super.key,
    required this.child,
    this.onTap,
    this.hasError = false,
    this.padding,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool hasError;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 55),
        padding: padding ?? AgrostSpacing.listItemPadding,
        decoration: BoxDecoration(
          color: AgrostColors.white,
          borderRadius: AgrostRadii.borderRadiusMd,
          border: Border.all(
            color: hasError ? AgrostColors.error : AgrostColors.border,
          ),
        ),
        child: child,
      ),
    );
  }
}
