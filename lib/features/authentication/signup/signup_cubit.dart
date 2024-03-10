import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/state_management/supabase_cubit/supabase_cubit.dart';

enum SingUpFormFields { email, password, confirmPassword }

class SignUpCubit extends SupabaseRequestCubit<AuthResponse?> {
  SignUpCubit(this._userAuthRepository) : super() {
    form = FormGroup({
      SingUpFormFields.email.name: FormControl<String>(validators: [Validators.required, Validators.email]),
      SingUpFormFields.password.name: FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
      SingUpFormFields.confirmPassword.name:
          FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    }, validators: [
      Validators.mustMatch(SingUpFormFields.password.name, SingUpFormFields.confirmPassword.name)
    ]);
  }

  final UserAuthRepository _userAuthRepository;

  late FormGroup form;

  Future<void> signUpWithEmail() async {
    if (form.valid) {
      final email = form.control(SingUpFormFields.email.name).value as String;
      final password = form.control(SingUpFormFields.password.name).value as String;
      await requestData(() => _userAuthRepository.signUpWithEmail(email: email, password: password));
    } else {
      form.markAllAsTouched();
    }
  }
}
