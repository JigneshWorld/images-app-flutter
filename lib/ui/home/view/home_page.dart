import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_app/ui/search/index.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final bool onlyBody;

  const HomePage({
    Key key,
    this.onlyBody = false,
  }) : super(key: key);

  Future<void> _search(BuildContext context) async {
    final query = await showSearch<String>(
      context: context,
      delegate: AppSearchDelegate(),
    );
    // BlocProvider.of<HomeBloc>(context).add(HomeEventInitialLoad(query));
  }

  @override
  Widget build(BuildContext context) {
    Widget body = BlocBuilder<HomeBloc, HomeState>(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No Images Found',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 48,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CLOSE'),
              ),
            ],
          ),
        );
      },
    );
    if (onlyBody) {
      return body;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search), onPressed: () => _search(context))
        ],
      ),
      body: body,
    );
    ;
  }
}
