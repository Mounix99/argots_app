import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/extensions/int_extensions.dart';
import 'package:agrost_app/common/theming/agrost_spacing.dart';
import 'package:agrost_app/common/widgets/agrost_card.dart';
import 'package:agrost_app/common/widgets/agrost_info_row.dart';
import 'package:agrost_app/common/widgets/agrost_loading_indicator.dart';
import 'package:agrost_app/common/widgets/agrost_section_header.dart';
import 'package:agrost_app/features/plant/plant_details/plant_details_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';

class AddedPlantDetailsScreen extends StatelessWidget {
  const AddedPlantDetailsScreen({super.key});

  static Widget create({required int plantId}) {
    return BlocProvider(
        create: (_) => PlantDetailsCubit(
              DIService.get<GetPlantInfoUseCase>(),
              DIService.get<GetListOfStagesUseCase>(),
              plantId: plantId,
            ),
        child: const AddedPlantDetailsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
      builder: (context, state) {
        if (state.plantDetailsRequestState.isLoading) {
          return const AgrostLoadingScreen();
        } else if (state.plantDetailsRequestState.isSuccess && state.plant != null) {
          return const _PlantDetailsWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _PlantDetailsWidget extends StatelessWidget {
  const _PlantDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantDetailsCubit, PlantDetailsState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(state.plant!.title)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AgrostSpacing.sm),
          child: ListView(
            shrinkWrap: true,
            children: [
              AgrostSpacing.verticalLg,
              if (state.plant?.photoUrl != null) ...[
                AgrostImageCard(imageUrl: state.plant!.photoUrl!),
                AgrostSpacing.verticalLg,
              ],
              _plantInfoBloc(context, state.plant!),
              AgrostSpacing.verticalHuge,
              _stagesBlock(context, state)
            ],
          ),
        ),
      );
    });
  }

  Widget _plantInfoBloc(BuildContext context, PlantModel plant) {
    return Padding(
      padding: const EdgeInsets.all(AgrostSpacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plant.title, style: context.textTheme.displayLarge),
          AgrostSpacing.verticalSm,
          if (plant.plantType != null) ...[
            AgrostInfoRow(
              label: "${context.strings.plant_family}:",
              value: plant.plantType!.join(", "),
            ),
            AgrostSpacing.verticalSm,
          ],
          if (plant.soilType != null) ...[
            AgrostInfoRow(
              label: "${context.strings.soil_type}:",
              value: plant.soilType!.join(", "),
            ),
            AgrostSpacing.verticalSm,
          ],
          AgrostInfoRow(
            label: "${context.strings.description}:",
            value: plant.description ?? "",
          ),
          AgrostSpacing.verticalSm,
          if (plant.public)
            Row(
              children: [
                Text(context.strings.plant_published_publicly, style: context.textTheme.bodyMedium),
                AgrostSpacing.horizontalSm,
                const Icon(Ionicons.bag_add_outline),
              ],
            )
        ],
      ),
    );
  }

  Widget _stagesBlock(BuildContext context, PlantDetailsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AgrostSpacing.sm),
          child: AgrostSectionHeader(
            title: context.strings.growth_stages,
            icon: Ionicons.moon_outline,
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
        separatorBuilder: (_, index) => AgrostSpacing.verticalSm,
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
    return AgrostCard(
      margin: const EdgeInsets.only(bottom: AgrostSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${"stage"} $stageNumber", style: context.textTheme.displaySmall),
              if (onDeletePressed != null)
                IconButton(onPressed: onDeletePressed, icon: const Icon(Ionicons.trash_outline)),
            ],
          ),
          AgrostSpacing.verticalXxl,
          if (stage.description?.isNotEmpty ?? false)
            AgrostIconInfoRow(
              icon: Ionicons.create_outline,
              title: stage.title,
              subtitle: stage.description,
            ),
          AgrostSpacing.verticalXxl,
          AgrostIconInfoRow(
            icon: Ionicons.calendar_outline,
            title: 'Duration',
            subtitle: stage.duration.formatAsDuration(context.strings),
          ),
        ],
      ),
    );
  }
}
