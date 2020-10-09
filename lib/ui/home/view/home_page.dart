import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Search Images';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (_, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.images.isNotEmpty) {
            final delegate = SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            );
            return GridView.builder(
              gridDelegate: delegate,
              itemBuilder: (_, index) {
                final image = state.images[index];
                return Image.network(image.previewURL);
              },
              itemCount: state.images.length,
            );
          }
          return Center(
            child: Text('No Images'),
          );
        },
      ),
    );
    ;
  }
}
