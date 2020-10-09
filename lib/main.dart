import 'package:flutter/material.dart';
import 'app/index.dart';
import 'infrastructure/index.dart';

void main() {
  runApp(
    ImagesApp(
      imagesRepo: ImagesRepoImpl(),
    ),
  );
}