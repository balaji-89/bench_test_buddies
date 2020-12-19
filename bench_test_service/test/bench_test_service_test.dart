import 'package:bench_test_service/bench_test_service.dart';

void main() async {
  try {
    String response =
        await User().forgotPassword('gokulakrishnanmay2a9@gmail.com');
    print(response);
  } on ErrorResponse catch (err) {
    print('Error:');
    print(err.toJson());
  }
}
