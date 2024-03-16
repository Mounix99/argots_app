import 'package:flutter_easyloading/flutter_easyloading.dart';

extension Dialog<T> on Future<T> {
  Future<T> withProgress({String? status, bool dismissOnTap = false}) {
    EasyLoading.show(status: status, dismissOnTap: dismissOnTap);
    return timeout(
      const Duration(seconds: 30),
    ).whenComplete(EasyLoading.dismiss);
  }
}

extension NullableDialog<T> on Future<T?> {
  Future<T?> withError(
      {required bool Function(Object?) checkError, required String Function(Object?) getErrorMessage}) {
    return onError((error, stackTrace) {
      if (checkError(error)) {
        EasyLoading.showError(getErrorMessage(error));
      }
      return null;
    });
  }
}
