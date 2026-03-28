import 'package:agrost_app/auth_cubit.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
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
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  authState.user?.email ?? '',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
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
