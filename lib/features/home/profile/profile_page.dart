import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile),
      ),
      body: Center(
        child: Text(context.strings.profile),
      ),
    );
  }
}
