import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/features/home/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => ProfileCubit(DIService.get()),
      child: const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.signOutState.isSuccess) {
            context.navigator.goToSplash();
          }
        },
        builder: (context, state) {
          return Center(
            child: ListView(
              children: [
                Text(context.user?.email ?? "", textAlign: TextAlign.center),
                TextButton(
                  onPressed: () => context.read<ProfileCubit>().signOut(),
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
