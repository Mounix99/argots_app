import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/theming/agrost_colors.dart';
import 'package:agrost_app/common/theming/agrost_spacing.dart';
import 'package:agrost_app/common/widgets/agrost_pill_tab_bar.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AgrostSpacing.xxl,
                AgrostSpacing.lg,
                AgrostSpacing.xxl,
                AgrostSpacing.md,
              ),
              child: Text(
                context.strings.plants,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            AgrostPillTabBar(
              controller: plantsTabController,
              tabs: [
                context.strings.my_plants,
                context.strings.plant_market,
              ],
            ),
            AgrostSpacing.verticalSm,
            Expanded(
              child: TabBarView(
                controller: plantsTabController,
                children: children,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _AddPlantFab(
        onPressed: () => context.navigator.goToCreatePlant(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _AddPlantFab extends StatelessWidget {
  const _AddPlantFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 53,
        width: 149,
        decoration: BoxDecoration(
          color: AgrostColors.primary,
          borderRadius: BorderRadius.circular(26.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Ionicons.leaf_outline,
              size: 20,
              color: AgrostColors.textPrimary,
            ),
            AgrostSpacing.horizontalSm,
            Text(
              'Add',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AgrostColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
