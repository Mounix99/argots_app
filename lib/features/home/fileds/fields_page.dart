import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FieldsPage extends StatelessWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.fields)),
      body: Center(
        child: Text(context.strings.fields),
      ),
    );
  }
}
