import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../images.dart';
import 'images_grid_view.dart';

class ImagesBodyBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      builder: (_, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (state.images.isNotEmpty) {
          return ImagesGridView(
            bloc: BlocProvider.of<ImagesBloc>(context),
            state: state,
          );
        }
        return NoImagesResult();
      },
    );
  }
}
