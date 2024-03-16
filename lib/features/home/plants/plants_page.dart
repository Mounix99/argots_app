import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlantsScreen extends HookWidget {
  const PlantsScreen({super.key, required this.shell, required this.children});

  final StatefulNavigationShell shell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final plantsTabController = useTabController(initialLength: children.length);
    plantsTabController.addListener(() => shell.goBranch(plantsTabController.index));
    return Scaffold(
        appBar: AppBar(
            title: Text(context.strings.plants),
            bottom: TabBar(
              controller: plantsTabController,
              onTap: shell.goBranch,
              tabs: [
                Tab(text: context.strings.my_plants),
                Tab(text: context.strings.plant_market),
              ],
            )),
        body: TabBarView(
          controller: plantsTabController,
          children: children,
        ));
  }
}
