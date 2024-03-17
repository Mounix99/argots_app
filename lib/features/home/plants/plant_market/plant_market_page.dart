import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/features/home/plants/plant_market/plant_market_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../common/pagination/pagination_controller.dart';

class PlantMarketPage extends HookWidget {
  const PlantMarketPage({super.key});

  static Widget create() {
    return BlocProvider(create: (_) => PlantMarketCubit(DIService.get()), child: const PlantMarketPage());
  }

  @override
  Widget build(BuildContext context) {
    final paginationController = usePaginationScrollController<PlantModel>(
      loadAction: context.read<PlantMarketCubit>().getMarketPlants,
    );
    return BlocConsumer<PlantMarketCubit, PlantMarketState>(
      listener: (context, state) {
        if (state.plantMarketRequestState.isError && state.errorMessage != null) {
          context.showSnackBar(message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
            onRefresh: context.read<PlantMarketCubit>().refresh,
            child: PagedListView<int, PlantModel>(
              pagingController: paginationController,
              builderDelegate: PagedChildBuilderDelegate<PlantModel>(
                itemBuilder: (context, plant, index) => PlantMarketListItem(plant: plant),
              ),
            ));
      },
    );
  }
}

class PlantMarketListItem extends StatelessWidget {
  const PlantMarketListItem({super.key, required this.plant});

  final PlantModel plant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => context.navigator.goToPlantDetails(plant.id.toString()),
        leading: plant.photoUrl != null ? Image.network(plant.photoUrl!) : const Icon(Ionicons.leaf),
        title: Text(plant.title),
        subtitle: plant.description != null ? Text(plant.description!) : null,
        trailing: plant.usedBy?.contains(context.user!.id) == true
            ? IconButton(icon: const Icon(Ionicons.checkmark_done), onPressed: () {})
            : IconButton(
                icon: const Icon(Ionicons.add),
                onPressed: () => context.read<PlantMarketCubit>().addPlantToUser(plant, context.user!.id),
              ));
  }
}
