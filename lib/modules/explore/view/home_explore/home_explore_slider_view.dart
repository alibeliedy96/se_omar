import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_omar/constants/localfiles.dart';
import 'package:mr_omar/constants/text_styles.dart';
import 'package:mr_omar/constants/themes.dart';
import 'package:mr_omar/language/app_localizations.dart';
import 'package:mr_omar/modules/explore/domain/models/slider_response.dart';
import 'package:mr_omar/modules/splash/components/page_pop_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;
  final List<SliderData> sliders;

  const HomeExploreSliderView({
    Key? key,
    this.opValue = 0.0,
    required this.click,
    required this.sliders,
  }) : super(key: key);

  @override
  State<HomeExploreSliderView> createState() => _HomeExploreSliderViewState();
}

class _HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    super.initState();


    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || widget.sliders.isEmpty) return;

      currentShowIndex = (currentShowIndex + 1) % widget.sliders.length;
      pageController.animateToPage(
        currentShowIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            currentShowIndex = index;
          },
          itemCount: widget.sliders.length,
          itemBuilder: (context, index) {
            return PagePopup(
              sliderData: widget.sliders[index],
              opValue: widget.opValue,
            );
          },
        ),
        Positioned(
          bottom: 32,
          right: Get.find<Loc>().isRTL ? null : 32,
          left: Get.find<Loc>().isRTL ? 32 : null,
          child: SmoothPageIndicator(
            controller: pageController,
            count: widget.sliders.length,
            effect: WormEffect(
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Theme.of(context).dividerColor,
              dotHeight: 10.0,
              dotWidth: 10.0,
              spacing: 5.0,
            ),
          ),
        ),
      ],
    );
  }
}

class PagePopup extends StatelessWidget {
  final SliderData sliderData;
  final double opValue;

  const PagePopup({Key? key, required this.sliderData, this.opValue = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            sliderData.imageUrl ?? "",
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey,
              child: const Icon(Icons.broken_image, size: 40, color: Colors.white),
            ),
          ),
        ),
        if ((sliderData.title ?? "").isNotEmpty)
          Positioned(
            bottom: 80,
            left: 24,
            right: 24,
            child: Opacity(
              opacity: opValue,
              child: Text(
                sliderData.title ?? "",
                textAlign: TextAlign.left,
                style: TextStyles(context)
                    .title()
                    .copyWith(color: AppTheme.whiteColor),
              ),
            ),
          ),
      ],
    );
  }
}

