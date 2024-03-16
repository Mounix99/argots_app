import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/pagination/pagination_controller.dart';
import 'package:agrost_app/features/home/plants/user_plants_list/user_plants_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyPlantsPage extends HookWidget {
  const MyPlantsPage({super.key});

  static Widget create() {
    return BlocProvider(
        create: (context) => MyPlantsCubit(DIService.get(), userId: context.user!.id), child: const MyPlantsPage());
  }

  @override
  Widget build(BuildContext context) {
    final paginationController = usePaginationScrollController(
      initAction: () => context.read<MyPlantsCubit>().getMyPlants(1),
      loadAction: context.read<MyPlantsCubit>().getMyPlants,
    );
    return BlocBuilder<MyPlantsCubit, MyPlantsState>(builder: (context, state) {
      return ListView.builder(
          controller: paginationController.scrollController,
          itemCount: state.plants.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Plant $index'));
          });
    });
  }
}
