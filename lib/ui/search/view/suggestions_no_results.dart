import 'package:flutter/material.dart';

class SuggestionsNoResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Text(
          'Press search button or enter on keyboard to search',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
