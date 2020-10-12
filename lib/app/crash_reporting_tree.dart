import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

/// Fimber log tree with sentry.io crash reporting API
class CrashReportingTree extends LogTree {
  static const List<String> _defaultLevels = ['W', 'E'];
  static const Map<String, SeverityLevel> _levelsMap = {
    'W': SeverityLevel.warning,
    'E': SeverityLevel.error,
  };
  final List<String> logLevels;

  SentryClient sentry;

  @override
  List<String> getLevels() => logLevels;

  CrashReportingTree({
    String dsn,
    String release,
    String environment,
    this.logLevels = _defaultLevels,
  }) {
    final envAttributes = Event(
      release: release,
      environment: environment ?? 'prod',
    );
    sentry = SentryClient(
      dsn: dsn,
      environmentAttributes: envAttributes,
    );
  }

  @override
  void log(String level, String message,
      {String tag, dynamic ex, StackTrace stacktrace}) {
    final event = Event(
      message: message,
      stackTrace: stacktrace,
      exception: ex,
      level: _levelsMap[level],
    );
    _logEvent(event);
  }

  Future<void> _logEvent(Event event) async {
    // Errors thrown in development mode are unlikely to be interesting. You can
    // check if you are running in dev mode using an assertion and omit sending
    // the report.
    if (kDebugMode) {
      debugPrint(event.toJson().toString());
      debugPrint('In dev mode. Not sending event to Sentry.io.');
      return;
    }

    debugPrint('Reporting to Sentry.io...');

    final response = await sentry.capture(event: event);

    if (response.isSuccessful) {
      debugPrint('Success! Event ID: ${response.eventId}');
    } else {
      debugPrint('Failed to event to Sentry.io: ${response.error}');
    }
  }
}
