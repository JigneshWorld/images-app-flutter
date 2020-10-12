import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'app/index.dart';
import 'infrastructure/index.dart';
import 'package:fimber/fimber.dart';

const BASE_URL = 'BASE_URL';
const API_KEY = 'API_KEY';
const ITEMS_PER_PAGE = 'ITEMS_PER_PAGE';
const MAX_SUGGESTIONS_TO_SHOW = 'MAX_SUGGESTIONS_TO_SHOW';
const GRID_TILE_STAGGERED = 'GRID_TILE_STAGGERED';
const SENTRY_DSN = 'SENTRY_DSN';

bool kAppGridTileStaggered = false;

Future<void> main() async {
  debugPrint('main: start');
  WidgetsFlutterBinding.ensureInitialized();

  final packageInfo = await PackageInfo.fromPlatform();

  final appName = packageInfo.appName;
  final version = '${packageInfo.version} - ${packageInfo.buildNumber}';
  final release = '$appName - $version';

  await DotEnv().load('.env');
  if (!DotEnv().isEveryDefined([
    BASE_URL,
    API_KEY,
    ITEMS_PER_PAGE,
    MAX_SUGGESTIONS_TO_SHOW,
    SENTRY_DSN,
  ])) {
    debugPrint('Please define every variables in .env file and run again');
    return;
  }

  if(Uri.tryParse(DotEnv().env[SENTRY_DSN]) == null){
    debugPrint('Please define valid SENTRY_DSN value in .env file and run again');
    return;
  }

  if (kDebugMode) {
    Fimber.plantTree(DebugTree());
    Bloc.observer = SimpleBlocObserver();
    EquatableConfig.stringify = true;
    Fimber.i(release);
    print(DotEnv().env);
  } else {
    Fimber.plantTree(CrashReportingTree(
      dsn: DotEnv().env[SENTRY_DSN],
      release: release,
    ));
  }

  FlutterError.onError = (details) async {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await runZonedGuarded<Future<void>>(() async {
    kAppGridTileStaggered =
        DotEnv().env[GRID_TILE_STAGGERED]?.toLowerCase() == 'true';

    final imagesRepo = PixabayImagesRepo(
      baseUrl: DotEnv().env[BASE_URL],
      apiKey: DotEnv().env[API_KEY],
      imagesPerPage: int.tryParse(DotEnv().env[ITEMS_PER_PAGE]) ?? 20,
    );

    final suggestionsRepo = SuggestionRepoImpl(
      store: SharedPrefKeyValueStore(),
      maxSuggestionsToShow:
          int.tryParse(DotEnv().env[MAX_SUGGESTIONS_TO_SHOW]) ?? 10,
    );

    runApp(
      ImagesApp(
        title: appName,
        imagesRepo: imagesRepo,
        suggestionsRepo: suggestionsRepo,
      ),
    );
  }, (e, s) {
    Fimber.e('main: app: unexpected error', ex: e, stacktrace: s);
  });
}
