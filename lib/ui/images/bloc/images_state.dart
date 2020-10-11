part of 'images_bloc.dart';

enum ImagesStateEnum { LOADING, EMPTY, SUCCESS, ERROR }

class ImagesState extends Equatable {
  final ImagesStateEnum state;
  final String query;

  final List<AppImage> images;

  final String errorMessage;

  final bool hasNextPage;
  final bool isLoadingNextPage;

  const ImagesState._({
    this.state,
    this.query,
    this.images = const [],
    this.hasNextPage = false,
    this.isLoadingNextPage = false,
    this.errorMessage,
  });

  static ImagesState loading() => ImagesState._(
        state: ImagesStateEnum.LOADING,
      );

  static ImagesState error(String message) => ImagesState._(
        state: ImagesStateEnum.ERROR,
        errorMessage: message,
      );

  static ImagesState empty() => ImagesState._(
        state: ImagesStateEnum.EMPTY,
      );

  static ImagesState success({
    List<AppImage> images,
    bool hasNextPage,
    String query,
  }) =>
      ImagesState._(
        state: ImagesStateEnum.SUCCESS,
        images: images,
        hasNextPage: hasNextPage,
        query: query,
      );

  int get itemCount => hasNextPage ? images.length + 1 : images.length;

  ImagesState copyWith({
    ImagesStateEnum state,
    String query,
    bool isLoading,
    List<AppImage> images,
    String errorMessage,
    bool hasNextPage,
    bool isLoadingNextPage,
  }) {
    return ImagesState._(
      state: state ?? this.state,
      query: query ?? this.query,
      images: images ?? this.images,
      errorMessage: errorMessage ?? this.errorMessage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
    );
  }

  @override
  List<Object> get props => [
        state,
        query,
        images,
        errorMessage,
        hasNextPage,
        isLoadingNextPage,
      ];
}
