import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/pagination/pagination_controller.dart';
import 'package:agrost_app/features/home/plants/user_plants_list/user_plants_list_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

class MyPlantsPage extends HookWidget {
  const MyPlantsPage({super.key});

  static Widget create() {
    return BlocProvider(
        create: (context) => MyPlantsCubit(DIService.get(), userId: context.user!.id), child: const MyPlantsPage());
  }

  @override
  Widget build(BuildContext context) {
    final pagingController = usePaginationScrollController<PlantModel>(
      loadAction: context.read<MyPlantsCubit>().getMyPlants,
    );
    return BlocConsumer<MyPlantsCubit, MyPlantsState>(listener: (context, state) {
      if (state.myPlantsRequestState.isError && state.errorMessage != null) {
        context.showSnackBar(message: state.errorMessage!);
      }
    }, builder: (context, state) {
      return RefreshIndicator(
        onRefresh: context.read<MyPlantsCubit>().refresh,
        child: PagedListView(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<PlantModel>(
              itemBuilder: (context, plant, index) => MyPlantListItem(plant: plant),
            )),
      );
    });
  }
}

class MyPlantListItem extends StatelessWidget {
  const MyPlantListItem({super.key, required this.plant});

  final PlantModel plant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.navigator.goToPlantDetails(plant.id.toString()),
      leading: plant.photoUrl != null ? Image.network(plant.photoUrl!) : const Icon(Ionicons.leaf),
      title: Text(plant.title),
      subtitle: plant.description != null ? Text(plant.description!) : null,
    );
  }
}
