import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.strings.plants)),
        body: Center(
          child: Text(context.strings.plants),
        ));
  }
}
