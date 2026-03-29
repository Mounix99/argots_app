import 'package:flutter/material.dart';
import '../theming/agrost_colors.dart';
import '../theming/agrost_spacing.dart';

/// Large container card matching Figma: #F4F6F8 fill, rx=28.
class AgrostCard extends StatelessWidget {
  const AgrostCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius,
    this.color,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AgrostRadii.borderRadiusXxl;

    Widget content = Container(
      padding: padding ?? AgrostSpacing.cardPadding,
      decoration: BoxDecoration(
        color: color ?? AgrostColors.surfaceContainer,
        borderRadius: effectiveRadius,
        border: border,
      ),
      child: child,
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveRadius,
        child: content,
      );
    }

    return content;
  }
}

/// Smaller card with rx=12 for info tiles and type-selection blocks.
class AgrostSmallCard extends StatelessWidget {
  const AgrostSmallCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.isSelected = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(AgrostSpacing.md),
      decoration: BoxDecoration(
        color: AgrostColors.surfaceContainer,
        borderRadius: AgrostRadii.borderRadiusMd,
        border: isSelected
            ? Border.all(color: AgrostColors.textPrimary, width: 1.5)
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}

/// Image card matching Figma: rx=28 for large hero images.
class AgrostImageCard extends StatelessWidget {
  const AgrostImageCard({
    super.key,
    required this.imageUrl,
    this.height = 200,
    this.borderRadius,
    this.placeholder,
  });

  final String imageUrl;
  final double height;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AgrostRadii.borderRadiusXxl;

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, chunkEvent) {
            if (chunkEvent == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: chunkEvent.expectedTotalBytes != null
                    ? chunkEvent.cumulativeBytesLoaded /
                        chunkEvent.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (_, error, stackTrace) =>
              placeholder ??
              const Center(child: Icon(Icons.broken_image_outlined, size: 48)),
        ),
      ),
    );
  }
}
