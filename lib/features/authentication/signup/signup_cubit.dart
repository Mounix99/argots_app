import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/usecases/user_auth_usecases/signup_usecase.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/base/form_request_cubit.dart';

enum SignUpFormFields { email, password, confirmPassword }

class SignUpCubit extends FormRequestCubit<AppUser> {
  SignUpCubit(this._signUpUseCase) : super() {
    form = FormGroup({
      SignUpFormFields.email.name: FormControl<String>(validators: [Validators.required, Validators.email]),
      SignUpFormFields.password.name: FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
      SignUpFormFields.confirmPassword.name:
          FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    }, validators: [
      Validators.mustMatch(SignUpFormFields.password.name, SignUpFormFields.confirmPassword.name)
    ]);
  }

  final SignUpUseCase _signUpUseCase;

  late FormGroup form;

  Future<void> signUpWithEmail() async {
    if (form.valid) {
      final email = form.control(SignUpFormFields.email.name).value as String;
      final password = form.control(SignUpFormFields.password.name).value as String;
      await requestData(() => _signUpUseCase((email: email, password: password, data: null)));
    } else {
      form.markAllAsTouched();
    }
  }
}
