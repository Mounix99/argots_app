import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/features/authentication/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/supabase_cubit/supabase_cubit_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Widget create() {
    return BlocProvider(create: (_) => SignUpCubit(DIService.get()), child: const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: BlocBuilder<SignUpCubit, SupabaseCubitState>(
          builder: (context, state) {
            final cubit = context.read<SignUpCubit>();
            final form = cubit.form;
            return ReactiveForm(
              formGroup: form,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: SingUpFormFields.email.name,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    ReactiveTextField(
                      formControlName: SingUpFormFields.password.name,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    ReactiveTextField(
                      formControlName: SingUpFormFields.confirmPassword.name,
                      decoration: const InputDecoration(labelText: 'Confirm Password'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SignUpCubit>().signUpWithEmail();
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
