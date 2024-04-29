import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';
import '../../plant/create_plant/create_plant_page.dart';
import 'manage_plants_cubit.dart';

class PlantsScreen extends HookWidget {
  const PlantsScreen({super.key, required this.shell, required this.children});

  final StatefulNavigationShell shell;
  final List<Widget> children;

  static Widget create({required StatefulNavigationShell shell, required List<Widget> children}) {
    return BlocProvider(
        create: (context) => ManagePlantsCubit(DIService.get(), context.user!.id),
        child: PlantsScreen(
          shell: shell,
          children: children,
        ));
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () => CreatePlantPage.push(context),
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          controller: plantsTabController,
          children: children,
        ));
  }
}
