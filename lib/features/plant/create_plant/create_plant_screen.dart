import 'dart:io';

import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/system_values/system_values_cache.dart';
import 'package:agrost_app/common/theming/agrost_colors.dart';
import 'package:agrost_app/common/theming/agrost_spacing.dart';
import 'package:agrost_app/common/widgets/agrost_card.dart';
import 'package:agrost_app/common/widgets/agrost_info_row.dart';
import 'package:agrost_app/common/widgets/agrost_loading_indicator.dart';
import 'package:agrost_app/common/widgets/agrost_primary_button.dart';
import 'package:agrost_app/common/widgets/agrost_section_header.dart';
import 'package:agrost_app/features/plant/create_plant/create_plant_cubit.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/system_values/entities/growth_season.dart';
import 'package:domain/system_values/entities/light_requirement.dart';
import 'package:domain/system_values/entities/plant_type.dart';
import 'package:domain/system_values/entities/soil_type.dart';
import 'package:domain/system_values/entities/watering_frequency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreatePlantScreen extends HookWidget {
  const CreatePlantScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => CreatePlantCubit(
        addPlantUseCase: DIService.get<AddPlantUseCase>(),
        addStageUseCase: DIService.get<AddStageUseCase>(),
        systemValuesCache: DIService.get<SystemValuesCache>(),
        authorId: context.user!.id,
      ),
      child: const CreatePlantScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stageTimeFormat = useState(StageTimeFormat.days);
    final cubit = context.read<CreatePlantCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.create_plant),
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back_outline),
          onPressed: () => context.navigator.goBack(),
        ),
      ),
      body: BlocListener<CreatePlantCubit, CreatePlantState>(
        listener: (context, state) {
          if (state.requestState.isError && state.errorMessage != null) {
            context.showSnackBar(message: state.errorMessage!);
          } else if (state.requestState.isSuccess) {
            context.showSnackBar(message: context.strings.plant_created_success);
            context.navigator.goBack();
          }
        },
        child: BlocBuilder<CreatePlantCubit, CreatePlantState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AgrostSpacing.screenHorizontal.copyWith(
                top: AgrostSpacing.lg,
                bottom: AgrostSpacing.massive,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BasicInfoSection(cubit: cubit, state: state),
                  AgrostSpacing.verticalXxl,
                  _PublicPlantSection(cubit: cubit, state: state),
                  AgrostSpacing.verticalXxl,
                  _GrowthStagesSection(stageTimeFormat: stageTimeFormat, cubit: cubit, state: state),
                  AgrostSpacing.verticalXxl,
                  AgrostPrimaryButton(
                    onPressed: state.requestState.isLoading ? null : cubit.createPlant,
                    label: context.strings.create_plant,
                    isLoading: state.requestState.isLoading,
                    icon: const Icon(Ionicons.checkmark_outline, color: AgrostColors.textPrimary),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Basic Information ────────────────────────────────────────────────────────

class _BasicInfoSection extends StatelessWidget {
  const _BasicInfoSection({required this.cubit, required this.state});

  final CreatePlantCubit cubit;
  final CreatePlantState state;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: cubit.plantForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AgrostSectionHeader(
            title: context.strings.basic_information,
            icon: Ionicons.leaf_outline,
          ),
          _PhotoPicker(cubit: cubit, state: state),
          AgrostSpacing.verticalLg,
          ReactiveTextField<String>(
            formControlName: CreatePlantFormFields.plantName.name,
            decoration: InputDecoration(
              labelText: context.strings.plant_name,
              prefixIcon: const Icon(Ionicons.leaf_outline),
            ),
            textInputAction: TextInputAction.next,
            validationMessages: {
              'required': (_) => context.strings.field_required,
            },
          ),
          AgrostSpacing.verticalLg,
          _MultiSelectChips<PlantType>(
            label: context.strings.plant_family,
            options: state.plantTypeOptions,
            selectedValues: state.selectedPlantTypes,
            getLabel: (e) => e.label,
            getValue: (e) => e.value,
            onToggle: cubit.togglePlantType,
            isLoaded: state.optionsLoaded,
          ),
          AgrostSpacing.verticalLg,
          _MultiSelectChips<SoilType>(
            label: context.strings.soil_type,
            options: state.soilTypeOptions,
            selectedValues: state.selectedSoilTypes,
            getLabel: (e) => e.label,
            getValue: (e) => e.value,
            onToggle: cubit.toggleSoilType,
            isLoaded: state.optionsLoaded,
          ),
          AgrostSpacing.verticalLg,
          _SingleSelectDropdown<LightRequirement>(
            label: context.strings.light_requirements,
            options: state.lightRequirementOptions,
            selectedValue: state.selectedLightRequirement,
            getLabel: (e) => e.label,
            getValue: (e) => e.value,
            onSelect: cubit.selectLightRequirement,
            isLoaded: state.optionsLoaded,
          ),
          AgrostSpacing.verticalLg,
          _SingleSelectDropdown<WateringFrequency>(
            label: context.strings.watering_frequency,
            options: state.wateringFrequencyOptions,
            selectedValue: state.selectedWateringFrequency,
            getLabel: (e) => e.label,
            getValue: (e) => e.value,
            onSelect: cubit.selectWateringFrequency,
            isLoaded: state.optionsLoaded,
          ),
          AgrostSpacing.verticalLg,
          _MultiSelectChips<GrowthSeason>(
            label: context.strings.growth_seasons,
            options: state.growthSeasonOptions,
            selectedValues: state.selectedGrowthSeasons,
            getLabel: (e) => e.label,
            getValue: (e) => e.value,
            onToggle: cubit.toggleGrowthSeason,
            isLoaded: state.optionsLoaded,
          ),
          AgrostSpacing.verticalLg,
          ReactiveTextField<String>(
            formControlName: CreatePlantFormFields.description.name,
            decoration: InputDecoration(
              labelText: context.strings.plant_description,
              prefixIcon: const Icon(Ionicons.create_outline),
              alignLabelWithHint: true,
            ),
            maxLines: 4,
            minLines: 3,
            textInputAction: TextInputAction.newline,
          ),
        ],
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({required this.cubit, required this.state});
  final CreatePlantCubit cubit;
  final CreatePlantState state;

  @override
  Widget build(BuildContext context) {
    return AgrostCard(
      padding: AgrostSpacing.cardPadding,
      child: Column(
        children: [
          if (state.selectedPhoto != null) ...[
            ClipRRect(
              borderRadius: AgrostRadii.borderRadiusMd,
              child: Image.file(
                File(state.selectedPhoto!.path),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            AgrostSpacing.verticalMd,
          ] else ...[
            Icon(Ionicons.image_outline, size: 48, color: context.colorScheme.onSurfaceVariant),
            AgrostSpacing.verticalSm,
            Text(
              context.strings.add_photo,
              style: context.textTheme.bodyMedium?.copyWith(color: AgrostColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            AgrostSpacing.verticalMd,
          ],
          Row(
            children: [
              Expanded(
                child: AgrostSmallCard(
                  onTap: () => cubit.pickPhoto(ImageSource.camera),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Ionicons.camera_outline),
                      AgrostSpacing.verticalXs,
                      Text(context.strings.take_photo,
                          style: context.textTheme.bodySmall, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              AgrostSpacing.horizontalMd,
              Expanded(
                child: AgrostSmallCard(
                  onTap: () => cubit.pickPhoto(ImageSource.gallery),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Ionicons.images_outline),
                      AgrostSpacing.verticalXs,
                      Text(context.strings.upload_from_gallery,
                          style: context.textTheme.bodySmall, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MultiSelectChips<T> extends StatelessWidget {
  const _MultiSelectChips({
    required this.label,
    required this.options,
    required this.selectedValues,
    required this.getLabel,
    required this.getValue,
    required this.onToggle,
    required this.isLoaded,
  });

  final String label;
  final List<T> options;
  final List<String> selectedValues;
  final String Function(T) getLabel;
  final String Function(T) getValue;
  final void Function(String) onToggle;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.bodyMedium?.copyWith(color: AgrostColors.textSecondary)),
        AgrostSpacing.verticalSm,
        if (!isLoaded)
          const SizedBox(height: 32, child: AgrostLoadingIndicator())
        else if (options.isEmpty)
          Text(context.strings.no_options_available,
              style: context.textTheme.bodySmall?.copyWith(color: AgrostColors.textTertiary))
        else
          Wrap(
            spacing: AgrostSpacing.sm,
            runSpacing: AgrostSpacing.xs,
            children: options.map((option) {
              final value = getValue(option);
              final isSelected = selectedValues.contains(value);
              return FilterChip(
                label: Text(getLabel(option)),
                selected: isSelected,
                onSelected: (_) => onToggle(value),
                selectedColor: AgrostColors.primary,
                checkmarkColor: AgrostColors.textPrimary,
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _SingleSelectDropdown<T> extends StatelessWidget {
  const _SingleSelectDropdown({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.getLabel,
    required this.getValue,
    required this.onSelect,
    required this.isLoaded,
  });

  final String label;
  final List<T> options;
  final String? selectedValue;
  final String Function(T) getLabel;
  final String Function(T) getValue;
  final void Function(String?) onSelect;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.bodyMedium?.copyWith(color: AgrostColors.textSecondary)),
        AgrostSpacing.verticalSm,
        if (!isLoaded)
          const SizedBox(height: 48, child: AgrostLoadingIndicator())
        else
          DropdownButtonFormField<String>(
            key: ValueKey(selectedValue),
            initialValue: selectedValue,
            hint: Text(context.strings.select_option),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: getValue(option),
                child: Text(getLabel(option)),
              );
            }).toList(),
            onChanged: onSelect,
            decoration: const InputDecoration(
              contentPadding: AgrostSpacing.inputContentPadding,
            ),
          ),
      ],
    );
  }
}

// ─── Public Plant ─────────────────────────────────────────────────────────────

class _PublicPlantSection extends StatelessWidget {
  const _PublicPlantSection({required this.cubit, required this.state});
  final CreatePlantCubit cubit;
  final CreatePlantState state;

  @override
  Widget build(BuildContext context) {
    return AgrostCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(context.strings.public_plant, style: context.textTheme.titleMedium),
                    AgrostSpacing.horizontalSm,
                    const Icon(Ionicons.earth_outline, size: 18),
                  ],
                ),
                AgrostSpacing.verticalSm,
                Text(
                  context.strings.public_plant_description,
                  style: context.textTheme.bodySmall?.copyWith(color: AgrostColors.textSecondary),
                ),
              ],
            ),
          ),
              Switch(
                value: state.isPublic,
                onChanged: (_) => cubit.togglePublic(),
                activeThumbColor: AgrostColors.textPrimary,
                activeTrackColor: AgrostColors.primary,
              ),
        ],
      ),
    );
  }
}

// ─── Growth Stages ────────────────────────────────────────────────────────────

class _GrowthStagesSection extends HookWidget {
  const _GrowthStagesSection({
    required this.stageTimeFormat,
    required this.cubit,
    required this.state,
  });

  final ValueNotifier<StageTimeFormat> stageTimeFormat;
  final CreatePlantCubit cubit;
  final CreatePlantState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgrostSectionHeader(
          title: context.strings.growth_stages,
          icon: Ionicons.moon_outline,
        ),
        Text(
          context.strings.growth_stages_description,
          style: context.textTheme.bodySmall?.copyWith(color: AgrostColors.textSecondary),
        ),
        AgrostSpacing.verticalLg,

        // Stage sub-form
        ReactiveForm(
          formGroup: cubit.stageForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReactiveTextField<String>(
                formControlName: CreatePlantFormFields.stageName.name,
                decoration: InputDecoration(
                  labelText: context.strings.stage_name,
                  prefixIcon: const Icon(Ionicons.leaf_outline),
                ),
                textInputAction: TextInputAction.next,
                validationMessages: {
                  'required': (_) => context.strings.field_required,
                },
              ),
              AgrostSpacing.verticalLg,
              ReactiveTextField<String>(
                formControlName: CreatePlantFormFields.stageDescription.name,
                decoration: InputDecoration(
                  labelText: context.strings.stage_description,
                  prefixIcon: const Icon(Ionicons.create_outline),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                minLines: 2,
              ),
              AgrostSpacing.verticalLg,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ReactiveTextField<int>(
                      formControlName: CreatePlantFormFields.stageDuration.name,
                      decoration: InputDecoration(
                        labelText: context.strings.duration,
                        prefixIcon: const Icon(Ionicons.calendar_outline),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.done,
                      validationMessages: {
                        'required': (_) => context.strings.field_required,
                        'min': (_) => context.strings.field_incorrect,
                      },
                    ),
                  ),
                  AgrostSpacing.horizontalMd,
                  SizedBox(
                    width: 130,
                    child: _TimeFormatSelector(stageTimeFormat: stageTimeFormat),
                  ),
                ],
              ),
              AgrostSpacing.verticalLg,
              AgrostSecondaryButton(
                onPressed: () => cubit.addStage(stageTimeFormat.value),
                label: context.strings.create_stage,
                icon: const Icon(Ionicons.add_outline),
              ),
            ],
          ),
        ),

        // Existing stages list
        if (state.stages.isNotEmpty) ...[
          AgrostSpacing.verticalLg,
          ...state.stages.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: AgrostSpacing.md),
                child: _LocalStageCard(
                  stage: entry.value,
                  stageNumber: entry.key + 1,
                  onDelete: () => cubit.removeStage(entry.key),
                ),
              )),
        ],
      ],
    );
  }
}

class _TimeFormatSelector extends HookWidget {
  const _TimeFormatSelector({required this.stageTimeFormat});
  final ValueNotifier<StageTimeFormat> stageTimeFormat;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<StageTimeFormat>(
      key: ValueKey(stageTimeFormat.value),
      initialValue: stageTimeFormat.value,
      decoration: InputDecoration(
        labelText: context.strings.time_format,
        contentPadding: AgrostSpacing.inputContentPadding,
      ),
      items: [
        DropdownMenuItem(value: StageTimeFormat.days, child: Text(context.strings.days(1))),
        DropdownMenuItem(value: StageTimeFormat.weeks, child: Text(context.strings.weeks(1))),
      ],
      onChanged: (value) {
        if (value != null) stageTimeFormat.value = value;
      },
    );
  }
}

class _LocalStageCard extends StatelessWidget {
  const _LocalStageCard({
    required this.stage,
    required this.stageNumber,
    required this.onDelete,
  });

  final LocalStageData stage;
  final int stageNumber;
  final VoidCallback onDelete;

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
              Text('Stage $stageNumber', style: context.textTheme.displaySmall),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Ionicons.trash_outline),
              ),
            ],
          ),
          AgrostSpacing.verticalMd,
          AgrostIconInfoRow(
            icon: Ionicons.leaf_outline,
            title: stage.name,
            subtitle: stage.description,
          ),
          AgrostSpacing.verticalMd,
          AgrostIconInfoRow(
            icon: Ionicons.calendar_outline,
            title: context.strings.duration,
            subtitle: '${stage.duration} ${stage.timeFormat == StageTimeFormat.days ? context.strings.days(stage.duration) : context.strings.weeks(stage.duration)}',
          ),
        ],
      ),
    );
  }
}
