import 'package:flutter_test/flutter_test.dart';

import 'package:bench_test_service/bench_test_service.dart';

void main() {
  RegisterResponse registerResponse = User().register(RegisterRequest(
      'Balaji', 'balaji89237@gmail.com', '12345678', '12345678'));
  print(registerResponse.toJson());
}
