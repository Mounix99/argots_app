import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit.dart';

enum SignInFormFields { email, password }

class SignInCubit extends SupabaseAuthRequestCubit<AuthResponse?> {
  SignInCubit(this._userAuthRepository) : super() {
    form = FormGroup({
      SignInFormFields.email.name: FormControl<String>(validators: [Validators.required, Validators.email]),
      SignInFormFields.password.name: FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    });
  }

  final UserAuthRepository _userAuthRepository;

  late FormGroup form;

  Future<void> signIn() async {
    if (form.valid) {
      final email = form.control(SignInFormFields.email.name).value as String;
      final password = form.control(SignInFormFields.password.name).value as String;
      await requestData(() => _userAuthRepository.signInWithEmail(email: email, password: password));
    } else {
      form.markAllAsTouched();
    }
  }
}
