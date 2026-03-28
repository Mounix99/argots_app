import 'package:agrost_app/common/dependency_injection/dependency_injection_service.dart';
import 'package:agrost_app/common/extensions/context_extensions.dart';
import 'package:agrost_app/common/state_management/base/request_state.dart';
import 'package:agrost_app/features/authentication/signin/signin_cubit.dart';
import 'package:domain/user/usecases/user_auth_usecases/signin_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInScreen extends HookWidget {
  const SignInScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (_) => SignInCubit(DIService.get<SignInUseCase>()),
      child: const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final obscurePassword = useState(true);

    return Scaffold(
      body: BlocListener<SignInCubit, FormRequestState>(
        listener: (context, state) {
          if (state.requestState.isError && state.errorMessage != null) {
            context.showSnackBar(message: state.errorMessage!);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Builder(
                builder: (context) {
                  final cubit = context.read<SignInCubit>();
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
                          context.strings.sign_in,
                          style: context.textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        ReactiveTextField<String>(
                          formControlName: SignInFormFields.email.name,
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
                          formControlName: SignInFormFields.password.name,
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
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => cubit.signIn(),
                          validationMessages: {
                            'required': (control) => context.strings.field_required,
                            'minLength': (control) => context.strings.field_incorrect,
                          },
                        ),
                        const SizedBox(height: 28),
                        BlocBuilder<SignInCubit, FormRequestState>(
                          builder: (context, state) => FilledButton(
                            onPressed: state.requestState.isLoading ? null : cubit.signIn,
                            child: state.requestState.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(context.strings.sign_in),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.navigator.goToSignUp(),
                          child: Text(context.strings.sign_up),
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
