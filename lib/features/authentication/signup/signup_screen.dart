import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';
import 'package:agrost_app/features/authentication/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (_) => SignUpCubit(DIService.get()),
      child: const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final obscurePassword = useState(true);
    final obscureConfirm = useState(true);

    return Scaffold(
      body: BlocListener<SignUpCubit, FormRequestState>(
        listener: (context, state) {
          if (state.requestState.isError && state.errorMessage != null) {
            context.showSnackBar(message: state.errorMessage!);
          } else if (state.requestState.isSuccess) {
            context.showSnackBar(
              message: context.strings.sign_up_success,
              duration: const Duration(seconds: 5),
            );
            context.navigator.goToSignIn();
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Builder(
                builder: (context) {
                  final cubit = context.read<SignUpCubit>();
                  return ReactiveForm(
                    formGroup: cubit.form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.eco_rounded,
                          size: 72,
                          color: context.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.strings.sign_up,
                          style: context.textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        ReactiveTextField<String>(
                          formControlName: SingUpFormFields.email.name,
                          decoration: InputDecoration(
                            labelText: context.strings.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validationMessages: {
                            'required': (control) => context.strings.field_required,
                            'email': (control) => context.strings.field_incorrect,
                          },
                        ),
                        const SizedBox(height: 16),
                        ReactiveTextField<String>(
                          formControlName: SingUpFormFields.password.name,
                          obscureText: obscurePassword.value,
                          decoration: InputDecoration(
                            labelText: context.strings.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => obscurePassword.value = !obscurePassword.value,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validationMessages: {
                            'required': (control) => context.strings.field_required,
                            'minLength': (control) => context.strings.field_incorrect,
                          },
                        ),
                        const SizedBox(height: 16),
                        ReactiveTextField<String>(
                          formControlName: SingUpFormFields.confirmPassword.name,
                          obscureText: obscureConfirm.value,
                          decoration: InputDecoration(
                            labelText: context.strings.confirm_password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirm.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => obscureConfirm.value = !obscureConfirm.value,
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => cubit.signUpWithEmail(),
                          validationMessages: {
                            'required': (control) => context.strings.field_required,
                            'minLength': (control) => context.strings.field_incorrect,
                            'mustMatch': (control) => context.strings.field_incorrect,
                          },
                        ),
                        const SizedBox(height: 28),
                        BlocBuilder<SignUpCubit, FormRequestState>(
                          builder: (context, state) => FilledButton(
                            onPressed: state.requestState.isLoading ? null : cubit.signUpWithEmail,
                            child: state.requestState.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(context.strings.sign_up),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.navigator.goToSignIn(),
                          child: Text(context.strings.sign_in),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
