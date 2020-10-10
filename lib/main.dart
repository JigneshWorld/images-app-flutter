import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/index.dart';
import 'infrastructure/index.dart';

const BASE_URL = 'BASE_URL';
const API_KEY = 'API_KEY';
const ITEMS_PER_PAGE = 'ITEMS_PER_PAGE';

Future<void> main() async {
  print('main: app start');
  try {
    await DotEnv().load('.env');
    if (!DotEnv().isEveryDefined([BASE_URL, API_KEY, ITEMS_PER_PAGE])) {
      print('Please define every variables in .env file to continue');
      return;
    }

    final baseUrl = DotEnv().env[BASE_URL];
    final apiKey = DotEnv().env[API_KEY];
    final itemsPerPage = DotEnv().env[ITEMS_PER_PAGE];

    final imagesRepo = ImagesRepoImpl(
      baseUrl: baseUrl,
      apiKey: apiKey,
      imagesPerPage: int.tryParse(itemsPerPage) ?? 20,
    );

    runApp(
      ImagesApp(
        imagesRepo: imagesRepo,
      ),
    );
  } catch (e, s) {
    print(e);
  }
}
