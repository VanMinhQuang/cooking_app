import 'package:flutter/material.dart';
import './utils.dart';

const goldenRatio = 1.61803399;
const defaultPortraitCardMargin = 16.0;
const defaultLandscapeCardMargin = 8.0;

class AnimatedCardsCarousel extends StatefulWidget {
  final Function? onFetchMore;
  const AnimatedCardsCarousel(
      {super.key,
        this.cardAspectRatio,
        this.cardMargin,
        this.onFetchMore,
        required this.cardsList});

  final double? cardAspectRatio;

  /// The margin around each card. Defaults to 16.0 if not provided.
  final double? cardMargin;

  /// The list of widgets to be displayed as cards in the carousel.
  final List<Widget> cardsList;

  @override
  State<AnimatedCardsCarousel> createState() => _AnimatedCardsCarouselState();
}

class _AnimatedCardsCarouselState extends State<AnimatedCardsCarousel>
    with TickerProviderStateMixin {
  late ScrollController scrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(scrollController.hasClients){
        scrollController.addListener(_scrollHandler);
      }else{
        Future.delayed(Duration(milliseconds: 300),() => scrollController.addListener(_scrollHandler));
      }
    });

  }
  
  void _scrollHandler(){
    var maxScroll = scrollController.position.maxScrollExtent;
    var currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      widget.onFetchMore?.call();
    }
    setState(() {
      scrollOffset = scrollController.offset;

    });
  }
  @override
  void dispose() {
    scrollController.removeListener(_scrollHandler); // Remove listener
    scrollController.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
    var screenSize = MediaQuery.of(context).size;
    var isPortrait = screenSize.height > screenSize.width;

    // Use provided aspect ratio or fallback to a sensible default
    double aspectRatio =
        widget.cardAspectRatio ?? (isPortrait ? goldenRatio : 10);
    double cardMargin = widget.cardMargin ??
        (isPortrait ? defaultPortraitCardMargin : defaultLandscapeCardMargin);

    return LayoutBuilder(builder: (_, constraints) {
      return ListView.builder(
        controller: scrollController,
        physics: const ClampingScrollPhysics(), // Prevents the elastic overscroll effect
        itemBuilder: (_, index) {
          return _AnimatedCard(
            index: index,
            scrollOffset: scrollController.offset,
            viewportHeight: constraints.maxHeight,
            cardWidth: constraints.maxWidth,
            cardAspectRatio: aspectRatio,
            cardMargin: cardMargin,
            card: widget.cardsList[index],
          );
        },
        itemCount: widget.cardsList.length,
      );
    });
  }
}

class _AnimatedCard extends StatelessWidget {
  final int index;
  final double scrollOffset;
  final double viewportHeight;
  final double cardAspectRatio;
  final double cardWidth;
  final double cardMargin;
  final Widget card;

  const _AnimatedCard(
      {required this.index,
        required this.scrollOffset,
        required this.viewportHeight,
        required this.card,
        required this.cardAspectRatio,
        required this.cardWidth,
        required this.cardMargin});

  @override
  Widget build(BuildContext context) {
    double cardHeight = (cardWidth / cardAspectRatio) + cardMargin * 2;
    double position = (index) * cardHeight - scrollOffset;

    // Define the different positional states for the animation
    double isDisappearing = -cardHeight;
    double isTop = 0;
    double isBottom = viewportHeight - cardHeight;
    double isAppearing = viewportHeight;

    // Calculate the transformation values
    double translateY = getInterpolateY(
        scrollOffset, index, cardHeight, position, isBottom, isAppearing);
    double scale = getAnimatedScale(
        position, isDisappearing, isTop, isBottom, isAppearing);
    double opacity = getAnimatedOpacity(
        position, isDisappearing, isTop, isBottom, isAppearing);

    return Container(
      margin: EdgeInsets.symmetric(vertical: cardMargin),
      child: Transform.translate(
        offset: Offset(
          0,
          translateY,
        ),
        child: Center(
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                height: cardWidth / cardAspectRatio,
                width: cardWidth,
                child: card,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
