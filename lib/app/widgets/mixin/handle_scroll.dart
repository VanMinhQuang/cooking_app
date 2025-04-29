import 'package:flutter/material.dart';

abstract class FetchProvider {
  void fetch([int offset]);
}

abstract class UpdateOffSet {
  void offSet([double offset]);
}

mixin ListSceneMixin<T extends StatefulWidget> on State<T> implements FetchProvider, UpdateOffSet {
  // static const _scrollDelta = 200.0;
  // static const _refreshTrigger = -60.0;
  // final double _scrollThreshold = ScreenConfig.getWidthPx(500);
  ScrollController scrollController = ScrollController();
  bool isBottomLoader = false;
  late bool canFetch; // true if data isn't fetching and there are more items to fetch
  bool canRefresh = true;

  @override
  void initState() {
    super.initState();
    canFetch = false;
    canRefresh = true;
    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    offSet(scrollController.offset);
    var maxScroll = scrollController.position.maxScrollExtent;
    var currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      fetch(-1);
    }

    // else if (maxScroll - currentScroll <= _scrollDelta &&
    //     canFetch &&
    //     fetch != null) {
    //   fetch(-1);
    // } else if (currentScroll < _refreshTrigger && canRefresh && fetch != null) {
    //   canRefresh = false;
    //   fetch(0);
    // } else if (currentScroll == 0) {
    //   canRefresh = true;
    // }
  }
}