import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/state_management/supabase_cubit/supabase_cubit_state.dart';
import 'package:agrost_app/features/authentication/signin/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static Widget create() {
    return BlocProvider(create: (context) => SignInCubit(DIService.get()), child: const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocBuilder<SignInCubit, SupabaseCubitState>(
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();
          final form = cubit.form;
          return ReactiveForm(
            formGroup: form,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: SignInFormFields.email.name,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  ReactiveTextField(
                    formControlName: SignInFormFields.password.name,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    onPressed: cubit.signIn,
                    child: const Text('Sign In'),
                  ),
                  if (state.requestState == RequestState.loading) const CircularProgressIndicator(),
                  if (state.requestState == RequestState.error) Text(state.errorMessage.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
