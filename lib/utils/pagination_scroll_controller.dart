import 'package:flutter/material.dart';

typedef AsyncBoolFunction = Future<bool> Function();

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  late AsyncBoolFunction loadAction;

  void init({
    required AsyncBoolFunction onLoadMore,
    ScrollController? controller,
  }) {
    loadAction = onLoadMore;
    scrollController = controller ?? ScrollController()
      ..addListener(scrollListener);
  }

  void dispose() {
    scrollController
      ..removeListener(scrollListener)
      ..dispose();
  }

  void scrollListener() {
    if (!stopLoading) {
      //load more data
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent * boundaryOffset &&
          !isLoading) {
        isLoading = true;
        loadAction().then((bool shouldStop) {
          isLoading = false;
          currentPage++;
          boundaryOffset = 1 - 1 / (currentPage * 2);
          if (shouldStop == true) {
            stopLoading = true;
          }
        });
      }
    }
  }
}
