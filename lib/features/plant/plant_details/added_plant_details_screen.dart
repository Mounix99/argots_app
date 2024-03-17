import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/features/plant/plant_details/plant_details_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';

class AddedPlantDetailsScreen extends StatelessWidget {
  const AddedPlantDetailsScreen({super.key});

  static Widget create({required int plantId}) {
    return BlocProvider(
        create: (_) => PlantDetailsCubit(DIService.get(), plantId: plantId), child: const AddedPlantDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
      builder: (context, state) {
        if (state.plantDetailsRequestState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.plantDetailsRequestState.isSuccess && state.plant != null) {
          return Scaffold(
            appBar: AppBar(title: Text(state.plant!.title)),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 16),
                  if (state.plant?.photoUrl != null) ...[
                    Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
                        elevation: 0,
                        color: context.colorScheme.onSurface,
                        child: Image.network(state.plant!.photoUrl!, loadingBuilder: (_, child, chunkEvent) {
                          if (chunkEvent == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: chunkEvent.expectedTotalBytes != null
                                  ? chunkEvent.cumulativeBytesLoaded / chunkEvent.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        })),
                    const SizedBox(height: 16),
                  ],
                  _plantInfoBloc(context, state.plant!),
                  const SizedBox(height: 40),
                  _stagesBlock(context, state)
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _plantInfoBloc(BuildContext context, PlantModel plant) {
    const space = SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plant.title, style: context.textTheme.displayLarge),
          space,
          if (plant.plantType != null) ...[
            _infoField(context, "${"createPlantPlantFamily"}: ", plant.plantType!.join(", ")),
            space,
          ],
          if (plant.soilType != null) ...[
            _infoField(context, "${"createPlantSoilType"}: ", plant.soilType!.join(", ")),
            space,
          ],
          _infoField(context, "${"createPlantDescription"}: ", plant.description ?? ""),
          space,
          if (plant.public)
            Row(
              children: [
                Text("plantPublishedPublicly", style: context.textTheme.bodyMedium),
                const SizedBox(width: 6),
                //Icon(PlantIcons.bag_3)
              ],
            )
        ],
      ),
    );
  }

  Widget _infoField(BuildContext context, String field, String value) {
    return Row(
      children: [Text(field, style: context.textTheme.bodyMedium), Text(value, style: context.textTheme.bodyMedium)],
    );
  }

  Widget _stagesBlock(BuildContext context, PlantDetailsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('createPlantGrowthStages', style: context.textTheme.displayMedium),
              const SizedBox(width: 5),
              //const Icon(PlantIcons.moon)
            ],
          ),
        ),
        //if (state.stages?.isNotEmpty ?? false) _stageList(state.stages!)
      ],
    );
  }

  // Widget _stageList(List<StageModel> stages) {
  //   return ListView.separated(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (_, index) => StageCard(stage: stages.elementAt(index), stageNumber: index + 1),
  //       separatorBuilder: (_, index) => const SizedBox(height: 8),
  //       itemCount: stages.length);
  // }
}
