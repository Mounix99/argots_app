import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:ionicons/ionicons.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => _onTap(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Ionicons.map_outline),
            selectedIcon: const Icon(Ionicons.map),
            label: context.strings.fields,
          ),
          NavigationDestination(
            icon: const Icon(Ionicons.leaf_outline),
            selectedIcon: const Icon(Ionicons.leaf),
            label: context.strings.plants,
          ),
          NavigationDestination(
            icon: const Icon(Ionicons.person_outline),
            selectedIcon: const Icon(Ionicons.person),
            label: context.strings.profile,
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  const AnimatedBranchContainer({super.key, required this.currentIndex, required this.children});

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (index, navigator) {
        return AnimatedOpacity(
          opacity: index == currentIndex ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: _branchNavigatorWrapper(index, navigator),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
