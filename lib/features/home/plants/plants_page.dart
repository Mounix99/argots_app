import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/theming/agrost_colors.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';
import 'manage_plants_cubit.dart';

class PlantsScreen extends HookWidget {
  const PlantsScreen({super.key, required this.shell, required this.children});

  final StatefulNavigationShell shell;
  final List<Widget> children;

  static Widget create({required StatefulNavigationShell shell, required List<Widget> children}) {
    return BlocProvider(
        create: (context) => ManagePlantsCubit(
              DIService.get<AddPlantToUserUseCase>(),
              DIService.get<RemovePlantFromUserUseCase>(),
              context.user!.id,
            ),
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton.icon(
                  onPressed: () => context.navigator.goToCreatePlant(),
                  icon: const Icon(Ionicons.add_outline, size: 18),
                  label: Text(context.strings.create_plant),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    backgroundColor: AgrostColors.primary,
                    foregroundColor: AgrostColors.textPrimary,
                  ),
                ),
              ),
            ],
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
