import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';
import '../general_plant_values_and_options/soil_type.dart';
import 'edit_plant_cubit.dart';
import '/common/extensions/sized_box_extensions.dart';

class EditPlantPage extends StatelessWidget {
  const EditPlantPage({super.key});

  static Future<int?> pushCreate(BuildContext context) => Navigator.of(context).push<int?>(_routeCreate());

  static Route<int?> _routeCreate() => MaterialPageRoute<int>(builder: (_) => EditPlantPage.create());

  static Widget create() {
    return BlocProvider(
        create: (context) => EditPlantCubit.create(DIService.get(), userId: context.user!.id),
        child: const EditPlantPage());
  }

  static Future<int?> pushEdit(BuildContext context, {required int plantId}) =>
      Navigator.of(context).push<int?>(_routeEdit(plantId));

  static Route<int?> _routeEdit(int plantId) => MaterialPageRoute<int>(builder: (_) => EditPlantPage.edit(plantId));

  static Widget edit(int plantId) {
    return BlocProvider(
        create: (context) => EditPlantCubit.edit(DIService.get(), userId: context.user!.id, plantId: plantId),
        child: const EditPlantPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPlantCubit, EditPlantState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                title: Text(state.plantId == null ? context.strings.create_plant : context.strings.update_plant)),
            body: ReactiveForm(
              formGroup: context.read<EditPlantCubit>().form,
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: SectionHeaderDelegate(context.strings.basic_information),
                    pinned: true,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Space.h(12),
                    ReactiveTextField(
                      formControlName: EditPlantFormFields.title.name,
                      decoration: InputDecoration(
                          labelText: context.strings.plant_name, hintText: context.strings.plant_name_hint),
                    ),
                    Space.h(12),
                    ReactiveTextField(
                      formControlName: EditPlantFormFields.description.name,
                      decoration: InputDecoration(
                          labelText: context.strings.plant_description,
                          hintText: context.strings.plant_description_hint),
                    ),
                    Space.h(12),
                    ReactiveDropdownField(
                        formControlName: EditPlantFormFields.soilType.name,
                        items: SoilType.values
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.nameByLocal(context.locale))))
                            .toList())
                  ])),
                ],
              ),
            ));
      },
    );
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(title, style: context.textTheme.headlineLarge),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
