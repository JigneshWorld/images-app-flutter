part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String query;

  final bool isLoading;

  final List<AppImage> images;

  final String errorMessage;

  final bool hasNextPage;
  final bool isLoadingNextPage;
  final String loadNextPageErrorMessage;

  const HomeState(
      {this.query,
      this.isLoading = true,
      this.images = const [],
      this.hasNextPage = false,
      this.isLoadingNextPage = false,
      this.errorMessage,
      this.loadNextPageErrorMessage});

  int get itemCount => hasNextPage ? images.length + 1 : images.length;

  HomeState copyWith({
    String query,
    bool isLoading,
    List<AppImage> images,
    String errorMessage,
    bool hasNextPage,
    bool isLoadingNextPage,
    String loadNextPageErrorMessage,
  }) {
    return HomeState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      images: images ?? this.images,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      loadNextPageErrorMessage:
          loadNextPageErrorMessage ?? this.loadNextPageErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        query,
        isLoading,
        images,
        errorMessage,
        hasNextPage,
        isLoadingNextPage,
        loadNextPageErrorMessage,
      ];
}
