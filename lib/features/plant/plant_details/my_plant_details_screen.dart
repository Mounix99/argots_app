import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/extensions/int_extensions.dart';
import 'package:agrost_app/features/plant/plant_details/plant_details_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';

class MyPlantDetailsScreen extends StatelessWidget {
  const MyPlantDetailsScreen({super.key});

  static Widget create({required int plantId}) {
    return BlocProvider(
        create: (_) => PlantDetailsCubit(DIService.get(), plantId: plantId), child: const MyPlantDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
      builder: (context, state) {
        if (state.plantDetailsRequestState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.plantDetailsRequestState.isSuccess && state.plant != null) {
          return const PlantDetailsWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class PlantDetailsWidget extends StatelessWidget {
  const PlantDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(builder: (context, state) {
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
    });
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
            _infoField(context, "${context.strings.plant_family}: ", plant.plantType!.join(", ")),
            space,
          ],
          if (plant.soilType != null) ...[
            _infoField(context, "${context.strings.soil_type}: ", plant.soilType!.join(", ")),
            space,
          ],
          _infoField(context, "${context.strings.description}: ", plant.description ?? ""),
          space,
          if (plant.public)
            Row(
              children: [
                Text(context.strings.plant_published_publicly, style: context.textTheme.bodyMedium),
                const SizedBox(width: 6),
                const Icon(Ionicons.bag_add_outline)
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
              Text(context.strings.growth_stages, style: context.textTheme.displayMedium),
              const SizedBox(width: 5),
              const Icon(Ionicons.moon_outline)
            ],
          ),
        ),
        if (state.stages?.isNotEmpty ?? false) _stageList(state.stages!)
      ],
    );
  }

  Widget _stageList(List<StageModel> stages) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => StageCard(stage: stages.elementAt(index), stageNumber: index + 1),
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemCount: stages.length);
  }
}

class StageCard extends StatelessWidget {
  final StageModel stage;
  final int stageNumber;
  final void Function()? onDeletePressed;
  const StageCard({super.key, required this.stage, required this.stageNumber, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      color: context.colorScheme.onSurface,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${"stage"} $stageNumber", style: context.textTheme.displaySmall),
                if (onDeletePressed != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [IconButton(onPressed: onDeletePressed, icon: const Icon(Ionicons.trash_outline))],
                  )
              ],
            ),
            const SizedBox(height: 25),
            if (stage.description?.isNotEmpty ?? false)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: context.colorScheme.surface,
                    child: const Icon(Ionicons.create_outline),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("stage", style: context.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(stage.title,
                          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimary)),
                      const SizedBox(height: 8),
                      if (stage.description != null)
                        Text(stage.description!,
                            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimary)),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 25),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    radius: 27,
                    backgroundColor: context.colorScheme.surface,
                    child: const Icon(Ionicons.calendar_outline)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('createStageDuration', style: context.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(stage.duration.formatAsDuration(context.strings),
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimary)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
