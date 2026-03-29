import 'package:flutter/material.dart';

import '../theming/agrost_colors.dart';
import '../theming/agrost_spacing.dart';

/// Custom pill-shaped segmented tab control.
///
/// Matches Figma design:
/// - Outer container: white fill, border #E6EAED, rx=19, height=38
/// - Selected segment: #F4F6F8 fill, rx=17.5
/// - Unselected segment: transparent, text color #6F7679
///
/// Uses [TabController.animation] to smoothly slide a single background pill
/// across segments rather than cross-fading individual containers.
class AgrostPillTabBar extends StatelessWidget {
  const AgrostPillTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.padding,
  });

  final TabController controller;
  final List<String> tabs;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final insets = padding ?? const EdgeInsets.symmetric(horizontal: AgrostSpacing.sm);
    final animation = controller.animation!;

    return Padding(
      padding: insets,
      child: Container(
        height: 38,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: AgrostColors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: AgrostColors.border, width: 0.5),
        ),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            final animValue = animation.value;

            return Stack(
              children: [
                // Sliding background pill
                LayoutBuilder(
                  builder: (context, constraints) {
                    final segmentWidth = constraints.maxWidth / tabs.length;
                    return Transform.translate(
                      offset: Offset(segmentWidth * animValue, 0),
                      child: Container(
                        width: segmentWidth,
                        decoration: BoxDecoration(
                          color: AgrostColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(17.5),
                        ),
                      ),
                    );
                  },
                ),
                // Tab labels
                Row(
                  children: List.generate(tabs.length, (index) {
                    final t = (1.0 - (animValue - index).abs()).clamp(0.0, 1.0);
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => controller.animateTo(index),
                        child: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: t > 0.5 ? FontWeight.w600 : FontWeight.w400,
                              color: Color.lerp(
                                AgrostColors.textSecondary,
                                AgrostColors.textPrimary,
                                t,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
