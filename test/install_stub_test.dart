import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Locks what the published `sentry.dart` config stub claims, since the stub is
/// copied into an app once and nothing re-checks the prose afterwards.
void main() {
  final String stub = File('assets/stubs/install/sentry_config.stub')
      .readAsStringSync();

  group('sentry_config.stub', () {
    test('scopes the named-route requirement to web', () {
      expect(stub, isNot(contains('reports zero')));
      expect(stub, contains('On web'));
    });

    test('does not await MagicSentry.run, which returns void', () {
      expect(stub, isNot(contains('await MagicSentry.run')));
      expect(stub, contains('MagicSentry.run(configure: configureSentry'));
    });
  });

  test('the example app carries the stub unchanged', () {
    final String example = File('example/lib/config/sentry.dart')
        .readAsStringSync();

    expect(example, stub);
  });
}
