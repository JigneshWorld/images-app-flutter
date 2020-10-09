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
          return _GridImages(
            bloc: BlocProvider.of<HomeBloc>(context),
            state: state,
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
            icon: Icon(Icons.search),
            onPressed: () => _search(context),
          )
        ],
      ),
      body: body,
    );
    ;
  }
}

class _GridImages extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final HomeState state;
  final HomeBloc bloc;

  _GridImages({Key key, this.state, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    );

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: GridView.builder(
        gridDelegate: delegate,
        itemBuilder: (_, index) {
          if ((index >= state.images.length)) {
            return _loaderGridItem();
          }
          final image = state.images[index];
          return Image.network(image.previewURL);
        },
        itemCount: state.itemCount,
        controller: _scrollController,
      ),
    );
  }

  Widget _loaderGridItem() {
    return Container(child: Center(child: CircularProgressIndicator()));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter < 500) {
      bloc.add(HomeEventLoadNextPage());
    }
    return false;
  }
}
