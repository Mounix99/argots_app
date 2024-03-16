import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/features/authentication/signin/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static Widget create() {
    return BlocProvider(create: (context) => SignInCubit(DIService.get()), child: const SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.sign_in),
      ),
      body: BlocConsumer<SignInCubit, SupabaseAuthCubitState>(
        listener: (context, state) {
          if (state.requestState.isSuccess) {
            context.authCubit.getUser();
            context.navigator.goToSplash();
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();
          final form = cubit.form;
          return ReactiveForm(
            formGroup: form,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ReactiveTextField(
                      formControlName: SignInFormFields.email.name,
                      decoration: InputDecoration(labelText: context.strings.email),
                      validationMessages: {
                        'required': (control) => context.strings.field_required,
                        'email': (control) => context.strings.field_incorrect,
                      }),
                  ReactiveTextField(
                      formControlName: SignInFormFields.password.name,
                      decoration: InputDecoration(labelText: context.strings.password),
                      validationMessages: {
                        'required': (control) => context.strings.field_required,
                        'minLength': (control) => context.strings.field_incorrect,
                      }),
                  ElevatedButton(
                    onPressed: () => cubit.signIn(),
                    child: Text(context.strings.sign_in),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.navigator.goToSignUp(),
                    child: Text(context.strings.sign_up),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
