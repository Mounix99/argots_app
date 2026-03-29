import 'package:agrost_app/auth_cubit.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/theming/agrost_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Widget create() => const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return Center(
            child: ListView(
              shrinkWrap: true,
              padding: AgrostSpacing.screenAll,
              children: [
                Text(
                  authState.user?.email ?? '',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
                AgrostSpacing.verticalXxl,
                TextButton(
                  onPressed: () => context.read<AuthCubit>().signOut(),
                  child: Text(context.strings.sign_out),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
