import 'package:flutter/material.dart';
import 'dart:async';

class SimpleCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final bool enlargeCenterPage;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final bool enableInfiniteScroll;
  final double viewportFraction;

  const SimpleCarousel({
    Key? key,
    required this.items,
    required this.height,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 300),
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.enableInfiniteScroll = true,
    this.viewportFraction = 1.0,
  }) : super(key: key);

  @override
  _SimpleCarouselState createState() => _SimpleCarouselState();
}

enum CarouselPageChangedReason { timed, manual }

class _SimpleCarouselState extends State<SimpleCarousel>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializePageController();
    
    if (widget.autoPlay && widget.items.length > 1) {
      _startAutoPlay();
    }
  }

  void _initializePageController() {
    final double viewportFraction = widget.enlargeCenterPage ? 0.85 : widget.viewportFraction;
    _pageController = PageController(
      initialPage: widget.enableInfiniteScroll && widget.items.length > 1 
          ? widget.items.length * 1000 // Start at middle for infinite scroll
          : 0,
      viewportFraction: viewportFraction,
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (_isDisposed || widget.items.length <= 1) return;
    
    _stopAutoPlay();
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_isDisposed || !mounted) {
        timer.cancel();
        return;
      }
      _nextPage();
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  void _nextPage() {
    if (_isDisposed || !_pageController.hasClients) return;
    
    final int nextPage = _pageController.page!.round() + 1;
    _pageController.animateToPage(
      nextPage,
      duration: widget.autoPlayAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  int _getActualIndex(int pageIndex) {
    if (!widget.enableInfiniteScroll || widget.items.isEmpty) {
      return pageIndex.clamp(0, widget.items.length - 1);
    }
    return pageIndex % widget.items.length;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Container(
          color: Colors.grey[200],
          child: Center(
            child: Text(
              'No hay elementos para mostrar',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.enableInfiniteScroll ? null : widget.items.length,
        onPageChanged: (int pageIndex) {
          if (_isDisposed) return;
          
          final actualIndex = _getActualIndex(pageIndex);
          
          setState(() {
            _currentPage = actualIndex;
          });
          
          widget.onPageChanged?.call(actualIndex, CarouselPageChangedReason.manual);
        },
        itemBuilder: (context, pageIndex) {
          final actualIndex = _getActualIndex(pageIndex);
          final item = widget.items[actualIndex];
          
          if (!widget.enlargeCenterPage) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: item,
            );
          }
          
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 1.0;
              
              if (_pageController.position.haveDimensions) {
                final page = _pageController.page ?? pageIndex.toDouble();
                final distance = (page - pageIndex).abs();
                scale = (1.0 - (distance * 0.1)).clamp(0.85, 1.0);
              }
              
              return Transform.scale(
                scale: scale,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.enlargeCenterPage ? 8.0 : 4.0,
                    vertical: widget.enlargeCenterPage ? (1.0 - scale) * 20 : 0,
                  ),
                  child: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Widget helper para indicadores de página
class CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double spacing;

  const CarouselIndicators({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.size = 8.0,
    this.spacing = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: size,
          height: size,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}