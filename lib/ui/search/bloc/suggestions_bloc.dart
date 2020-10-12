import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:images_app/domain/index.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  final SuggestionsRepo suggestionsRepo;

  SuggestionsBloc({@required this.suggestionsRepo}) : super(SuggestionsState());

  @override
  Stream<SuggestionsState> mapEventToState(
    SuggestionsEvent event,
  ) async* {
    if (event is SuggestionsEventQueryChanged) {
      yield state.copyWith(event.query, []);
      final suggestions = await suggestionsRepo.suggestions(event.query);
      yield state.copyWith(event.query, suggestions);
    }
  }
}
