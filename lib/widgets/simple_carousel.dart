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

  SimpleCarousel({
    required this.items,
    required this.height,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.enlargeCenterPage = false,
    this.onPageChanged,
  });

  @override
  _SimpleCarouselState createState() => _SimpleCarouselState();
}

enum CarouselPageChangedReason { timed, manual }

class _SimpleCarouselState extends State<SimpleCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: widget.enlargeCenterPage ? 0.85 : 1.0);
    
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_currentPage < widget.items.length - 1) {
        _pageController.nextPage(
          duration: widget.autoPlayAnimationDuration,
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: widget.autoPlayAnimationDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.items.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(page, CarouselPageChangedReason.manual);
          }
        },
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(
              horizontal: widget.enlargeCenterPage ? (_currentPage == index ? 5.0 : 15.0) : 5.0,
              vertical: widget.enlargeCenterPage ? (_currentPage == index ? 5.0 : 20.0) : 5.0,
            ),
            child: widget.items[index],
          );
        },
      ),
    );
  }
}