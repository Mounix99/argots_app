import 'package:domain/plants/entities/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../common/theming/agrost_colors.dart';
import '../../../../common/theming/agrost_spacing.dart';

/// Plant list card matching the Figma design.
///
/// - rx=28, height=104, horizontal padding=8
/// - Left: white circular container (56x56) with plant image or icon
/// - Center: plant title
/// - Right: customizable trailing widget
class PlantCard extends StatelessWidget {
  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
    this.trailing,
    this.backgroundColor,
  });

  final PlantModel plant;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AgrostSpacing.sm, vertical: AgrostSpacing.xs),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 104,
          decoration: BoxDecoration(
            color: backgroundColor ?? AgrostColors.surfaceContainer,
            borderRadius: BorderRadius.circular(AgrostRadii.xxl),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AgrostSpacing.xxl, vertical: AgrostSpacing.md),
          child: Row(
            children: [
              _PlantImageContainer(photoUrl: plant.photoUrl),
              AgrostSpacing.horizontalLg,
              Expanded(
                child: Text(
                  plant.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null) ...[
                AgrostSpacing.horizontalMd,
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlantImageContainer extends StatelessWidget {
  const _PlantImageContainer({this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: AgrostColors.white,
        borderRadius: BorderRadius.all(Radius.circular(AgrostRadii.xxl)),
      ),
      clipBehavior: Clip.antiAlias,
      child: photoUrl != null
          ? Image.network(
              photoUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stack) => const _PlantFallbackIcon(),
            )
          : const _PlantFallbackIcon(),
    );
  }
}

class _PlantFallbackIcon extends StatelessWidget {
  const _PlantFallbackIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Ionicons.leaf_outline,
        size: 24,
        color: AgrostColors.textSecondary,
      ),
    );
  }
}
