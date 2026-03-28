import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/usecases/user_auth_usecases/signin_usecase.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/base/form_request_cubit.dart';

enum SignInFormFields { email, password }

class SignInCubit extends FormRequestCubit<AppUser> {
  SignInCubit(this._signInUseCase) : super() {
    form = FormGroup({
      SignInFormFields.email.name: FormControl<String>(validators: [Validators.required, Validators.email]),
      SignInFormFields.password.name: FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    });
  }

  final SignInUseCase _signInUseCase;

  late FormGroup form;

  Future<void> signIn() async {
    if (form.valid) {
      final email = form.control(SignInFormFields.email.name).value as String;
      final password = form.control(SignInFormFields.password.name).value as String;
      await requestData(() => _signInUseCase((email: email, password: password)));
    } else {
      form.markAllAsTouched();
    }
  }
}
