import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/theming/agrost_colors.dart';
import 'package:agrost_app/features/home/plants/plant_market/plant_market_cubit.dart';
import 'package:agrost_app/features/home/plants/widgets/plant_card.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_market_plants_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../common/pagination/pagination_controller.dart';
import '../manage_plants_cubit.dart';

class PlantMarketPage extends HookWidget {
  const PlantMarketPage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (_) => PlantMarketCubit(
        DIService.get<GetMarketPlantsUseCase>(),
        DIService.get<AddPlantToUserUseCase>(),
        DIService.get<AppEventBus>(),
      ),
      child: const PlantMarketPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paginationController = usePaginationScrollController<PlantModel>(
      loadAction: context.read<PlantMarketCubit>().getMarketPlants,
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<PlantMarketCubit, PlantMarketState>(
          listener: (context, state) {
            if (state.plantMarketRequestState.isError && state.errorMessage != null) {
              context.showSnackBar(message: state.errorMessage!);
            }
            if (state.plantMarketRequestState.isInitial) {
              paginationController.refresh();
            }
          },
        ),
        BlocListener<ManagePlantsCubit, ManagePlantsState>(
          listener: (context, state) {
            if (state.addPlantToUserRequestState.isSuccess || state.removePlantFromUserRequestState.isSuccess) {
              context.read<PlantMarketCubit>().refresh();
              context.read<ManagePlantsCubit>().refresh();
            }
          },
        ),
      ],
      child: BlocBuilder<PlantMarketCubit, PlantMarketState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => paginationController.refresh(),
            child: PagingListener(
              controller: paginationController,
              builder: (context, state, fetchNextPage) => PagedListView<int, PlantModel>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<PlantModel>(
                  itemBuilder: (context, plant, index) => PlantMarketListItem(plant: plant),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlantMarketListItem extends StatelessWidget {
  const PlantMarketListItem({super.key, required this.plant});

  final PlantModel plant;

  @override
  Widget build(BuildContext context) {
    final isAdded = plant.usedBy?.contains(context.user!.id) == true;

    return PlantCard(
      plant: plant,
      onTap: () => context.navigator.goToPlantDetails(plant.id.toString()),
      backgroundColor: isAdded ? AgrostColors.primary : AgrostColors.surfaceContainer,
      trailing: GestureDetector(
        onTap: () {
          if (isAdded) {
            context.read<ManagePlantsCubit>().removePlantFromUser(plant.id);
          } else {
            context.read<ManagePlantsCubit>().addPlantToUser(plant.id);
          }
        },
        child: Icon(
          isAdded ? Ionicons.checkmark_done_outline : Ionicons.add_outline,
          size: 22,
          color: AgrostColors.textPrimary,
        ),
      ),
    );
  }
}
