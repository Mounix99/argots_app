import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/extensions/int_extensions.dart';
import 'package:agrost_app/common/theming/agrost_colors.dart';
import 'package:agrost_app/common/theming/agrost_spacing.dart';
import 'package:agrost_app/common/widgets/agrost_card.dart';
import 'package:agrost_app/common/widgets/agrost_info_row.dart';
import 'package:agrost_app/common/widgets/agrost_loading_indicator.dart';
import 'package:agrost_app/common/widgets/agrost_section_header.dart';
import 'package:agrost_app/features/plant/plant_details/plant_details_cubit.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/delete_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class AddedPlantDetailsScreen extends StatelessWidget {
  const AddedPlantDetailsScreen({super.key});

  static Widget create({required int plantId, required String currentUserId}) {
    return BlocProvider(
      create: (_) => PlantDetailsCubit(
        DIService.get<GetPlantInfoUseCase>(),
        DIService.get<GetListOfStagesUseCase>(),
        DIService.get<DeletePlantUseCase>(),
        DIService.get<RemovePlantFromUserUseCase>(),
        DIService.get<AppEventBus>(),
        plantId: plantId,
        currentUserId: currentUserId,
      ),
      child: const AddedPlantDetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantDetailsCubit, PlantDetailsState>(
      listenWhen: (prev, curr) => prev.deleteRequestState != curr.deleteRequestState,
      listener: (context, state) {
        if (state.deleteRequestState.isError && state.errorMessage != null) {
          context.showSnackBar(message: state.errorMessage!);
        } else if (state.deleteRequestState.isSuccess) {
          context.navigator.goBack();
        }
      },
      builder: (context, state) {
        if (state.plantDetailsRequestState.isLoading) {
          return const AgrostLoadingScreen();
        } else if (state.plantDetailsRequestState.isSuccess && state.plant != null) {
          return _PlantDetailsWidget(plant: state.plant!, state: state);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _PlantDetailsWidget extends StatelessWidget {
  const _PlantDetailsWidget({required this.plant, required this.state});

  final PlantModel plant;
  final PlantDetailsState state;

  bool get _showDeleteButton => state.isAuthor || state.isInUsedBy;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlantDetailsCubit>();
    final isDeleting = state.deleteRequestState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.plant_details),
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back_outline),
          onPressed: () => context.navigator.goBack(),
        ),
        actions: [
          if (state.isAuthor)
            IconButton(
              icon: const Icon(Ionicons.create_outline),
              onPressed: isDeleting ? null : () => context.navigator.goToEditPlant(plant),
            ),
          if (_showDeleteButton)
            if (isDeleting)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AgrostSpacing.lg),
                child: AgrostLoadingIndicator(),
              )
            else
              IconButton(
                icon: const Icon(Ionicons.trash_outline),
                onPressed: () => _onDeletePressed(context, cubit),
              ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AgrostSpacing.lg),
          children: [
            AgrostSpacing.verticalLg,
            if (plant.photoUrl != null) ...[
              AgrostImageCard(imageUrl: plant.photoUrl!, height: 220),
              AgrostSpacing.verticalLg,
            ],
            _PlantInfoSection(plant: plant),
            AgrostSpacing.verticalXxl,
            _StagesSection(state: state),
            AgrostSpacing.verticalMassive,
          ],
        ),
      ),
    );
  }

  void _onDeletePressed(BuildContext context, PlantDetailsCubit cubit) {
    if (state.isAuthor) {
      _showAuthorDeleteSheet(context, cubit);
    } else {
      _confirmRemoveFromList(context, cubit);
    }
  }

  void _showAuthorDeleteSheet(BuildContext context, PlantDetailsCubit cubit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AgrostRadii.xxl)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AgrostSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AgrostSpacing.xxl, vertical: AgrostSpacing.sm),
                  child: Text(
                    context.strings.delete_plant_confirmation,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const Divider(),
                if (state.isInUsedBy)
                  ListTile(
                    leading: const Icon(Ionicons.remove_circle_outline),
                    title: Text(context.strings.remove_from_my_list),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      cubit.removePlantFromUser();
                    },
                  ),
                ListTile(
                  leading: Icon(Ionicons.trash_outline, color: AgrostColors.error),
                  title: Text(
                    context.strings.delete_plant_completely,
                    style: TextStyle(color: AgrostColors.error),
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    cubit.deletePlant();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmRemoveFromList(BuildContext context, PlantDetailsCubit cubit) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.strings.delete_plant),
        content: Text(context.strings.remove_from_my_list),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              cubit.removePlantFromUser();
            },
            child: Text(
              context.strings.remove_from_my_list,
              style: TextStyle(color: AgrostColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Plant Info Section ───────────────────────────────────────────────────────

class _PlantInfoSection extends StatelessWidget {
  const _PlantInfoSection({required this.plant});

  final PlantModel plant;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plant.title, style: context.textTheme.displayLarge),
        AgrostSpacing.verticalMd,

        if (plant.plantType != null && plant.plantType!.isNotEmpty) ...[
          AgrostInfoRow(
            label: "${context.strings.plant_family}:",
            value: plant.plantType!.join(", "),
          ),
          AgrostSpacing.verticalSm,
        ],

        if (plant.soilType != null && plant.soilType!.isNotEmpty) ...[
          AgrostInfoRow(
            label: "${context.strings.soil_type}:",
            value: plant.soilType!.join(", "),
          ),
          AgrostSpacing.verticalSm,
        ],

        if (plant.lightRequirements != null) ...[
          AgrostInfoRow(
            label: "${context.strings.light_requirements}:",
            value: plant.lightRequirements!,
          ),
          AgrostSpacing.verticalSm,
        ],

        if (plant.wateringFrequency != null) ...[
          AgrostInfoRow(
            label: "${context.strings.watering_frequency}:",
            value: plant.wateringFrequency!,
          ),
          AgrostSpacing.verticalSm,
        ],

        if (plant.growthSeasons != null && plant.growthSeasons!.isNotEmpty) ...[
          AgrostInfoRow(
            label: "${context.strings.growth_seasons}:",
            value: plant.growthSeasons!.join(", "),
          ),
          AgrostSpacing.verticalSm,
        ],

        if (plant.description != null && plant.description!.isNotEmpty) ...[
          AgrostInfoRow(
            label: "${context.strings.description}:",
            value: plant.description!,
          ),
          AgrostSpacing.verticalSm,
        ],

        AgrostInfoRow(
          label: "${context.strings.public}:",
          value: plant.public ? "Yes" : "No",
        ),
        AgrostSpacing.verticalSm,

        AgrostInfoRow(
          label: "${context.strings.version}:",
          value: plant.version,
        ),
        AgrostSpacing.verticalSm,

        AgrostInfoRow(
          label: "${context.strings.created_at}:",
          value: dateFormat.format(plant.createdAt),
        ),

        if (plant.lastUpdateAt != null) ...[
          AgrostSpacing.verticalSm,
          AgrostInfoRow(
            label: "${context.strings.last_updated}:",
            value: dateFormat.format(plant.lastUpdateAt!),
          ),
        ],
      ],
    );
  }
}

// ─── Stages Section ───────────────────────────────────────────────────────────

class _StagesSection extends StatelessWidget {
  const _StagesSection({required this.state});

  final PlantDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AgrostSectionHeader(
          title: context.strings.growth_stages,
          icon: Ionicons.moon_outline,
        ),
        if (state.stagesRequestState.isLoading)
          const Center(child: AgrostLoadingIndicator())
        else if (state.stages != null && state.stages!.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.stages!.length,
            separatorBuilder: (_, _) => AgrostSpacing.verticalMd,
            itemBuilder: (_, index) => StageCard(
              stage: state.stages!.elementAt(index),
              stageNumber: index + 1,
            ),
          ),
      ],
    );
  }
}

// ─── Stage Card ───────────────────────────────────────────────────────────────

class StageCard extends StatelessWidget {
  final StageModel stage;
  final int stageNumber;
  final VoidCallback? onDeletePressed;

  const StageCard({
    super.key,
    required this.stage,
    required this.stageNumber,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AgrostCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Stage $stageNumber", style: context.textTheme.displaySmall),
              if (onDeletePressed != null)
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Ionicons.trash_outline),
                ),
            ],
          ),
          AgrostSpacing.verticalXxl,
          AgrostIconInfoRow(
            icon: Ionicons.create_outline,
            title: stage.title,
            subtitle: stage.description?.isNotEmpty == true ? stage.description : null,
          ),
          AgrostSpacing.verticalXxl,
          AgrostIconInfoRow(
            icon: Ionicons.calendar_outline,
            title: context.strings.duration,
            subtitle: stage.duration.formatAsDuration(context.strings),
          ),
        ],
      ),
    );
  }
}
