import 'package:flutter_test/flutter_test.dart';
import 'package:iot_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('HacsServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
