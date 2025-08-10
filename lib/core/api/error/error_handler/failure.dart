
import '../../../services/app_snake_bar.dart';

class Failure {
  int? code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
  TypeMsg type;

  Failure(this.code, this.message, [this.type = TypeMsg.error]);

  factory Failure.fromJson(Map<String, dynamic> json) {
    String parsedMessage;

    // لو message عبارة عن List (مثلاً: ["Phone number is invalid"])
    if (json['message'] is List) {
      parsedMessage = (json['message'] as List).join(', ');
    } else {
      parsedMessage = json['message']?.toString() ?? 'Something went wrong';
    }

    return Failure(
      json['statusCode'] ?? 0,
      parsedMessage,
      TypeMsg.error,
    );
  }

  @override
  String toString() {
    return 'Failure{code: $code, message: $message, type: $type}';
  }

  void printInfo(String from) {
    print('from => $from : Failure{code: $code, message: $message, type: $type}');
  }
}

enum TypeMsg { ok, error, warning }
extension FailureEx on Failure {
  void showToast() {
    ToastType toastType = switch (type) {
      TypeMsg.ok => ToastType.info,
      TypeMsg.error => ToastType.error,
      TypeMsg.warning => ToastType.warning,
    };

    AppSnackBar.show(message, type: toastType);
  }
}