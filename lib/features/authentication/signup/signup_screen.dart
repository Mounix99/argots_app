import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
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
        appBar: AppBar(title: Text(context.strings.sign_up)),
        body: BlocConsumer<SignUpCubit, SupabaseAuthCubitState>(
          listener: (context, state) {
            if (state.requestState.isSuccess) {
              context.navigator.goToSplash();
            }
          },
          builder: (context, state) {
            final cubit = context.read<SignUpCubit>();
            final form = cubit.form;
            return ReactiveForm(
              formGroup: form,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ReactiveTextField(
                      formControlName: SingUpFormFields.email.name,
                      decoration: InputDecoration(labelText: context.strings.email),
                      validationMessages: {
                        'required': (control) => context.strings.field_required,
                        'email': (control) => context.strings.field_incorrect,
                      },
                    ),
                    ReactiveTextField(
                      formControlName: SingUpFormFields.password.name,
                      decoration: InputDecoration(labelText: context.strings.password),
                      validationMessages: {
                        'required': (control) => context.strings.field_required,
                        'minLength': (control) => context.strings.field_incorrect,
                      },
                    ),
                    ReactiveTextField(
                      formControlName: SingUpFormFields.confirmPassword.name,
                      decoration: InputDecoration(labelText: context.strings.confirm_password),
                      validationMessages: {
                        'required': (control) => context.strings.field_required,
                        'minLength': (control) => context.strings.field_incorrect,
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SignUpCubit>().signUpWithEmail();
                      },
                      child: Text(context.strings.sign_up),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.navigator.goToSignIn(),
                      child: Text(context.strings.sign_in),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
