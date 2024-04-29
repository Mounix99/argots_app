import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/dependency_injection/dependency_injection_service.dart';
import 'create_plant_cubit.dart';

class CreatePlantPage extends StatelessWidget {
  const CreatePlantPage({super.key});

  static Future<int?> push(BuildContext context) => Navigator.of(context).push<int?>(_route());

  static Route<int?> _route() => MaterialPageRoute<int>(builder: (_) => CreatePlantPage.create());

  static Widget create() {
    return BlocProvider(
        create: (context) => CreatePlantCubit(DIService.get(), userId: context.user!.id),
        child: const CreatePlantPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.create_plant)),
    );
  }
}
