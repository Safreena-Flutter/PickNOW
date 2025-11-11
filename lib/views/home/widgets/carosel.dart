import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:picknow/costants/mediaquery/mediaquery.dart';
import 'package:picknow/costants/theme/appcolors.dart';
import 'package:picknow/views/widgets/customtext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

 final List<Map<String, String>> carouselItems = [
  {
    "image":
        "https://images.pexels.com/photos/3872425/pexels-photo-3872425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "text": "Welcome to a Healthier Lifestyle!",
  },
  {
    "image":
        "https://lh5.googleusercontent.com/proxy/sO9mLL8g4ur3ClhP9SPsNCfzD3VNagFIHP6w6STlFANHTPvptXlWz0imh3dQa492xaTwZmCN_1s7Y02Q28psY43Gyo7vzPrBeppPn9ZqPZ-Kljm29CQr28__",
    "text": "Explore Nature’s Finest Products",
  },
  {
    "image":
        "https://images.pexels.com/photos/10631301/pexels-photo-10631301.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "text": "Pure Goodness, Straight from Nature",
  },
  {
    "image":
        "https://images.pexels.com/photos/16244100/pexels-photo-16244100/free-photo-of-close-up-of-natural-handmade-soap-bars.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "text": "Gentle Care, Handmade with Love",
  },
  {
    "image":
        "https://www.shutterstock.com/image-photo/legumes-lentils-chickpea-beans-assortment-260nw-1960506445.jpg",
    "text": "Wholesome Goodness in Every Bite",
  },
];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: carouselItems.length,
          options: CarouselOptions(
            height: mediaqueryheight(0.25, context),
           
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          itemBuilder: (context, index, realIndex) {
            return Stack(
              children: [
                // Image
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        
                        carouselItems[index]["image"]!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                    top: 140,
                    left: 20,
                    right: 20,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: carouselItems[index]["text"]!,
                      size: 0.05,
                      color: AppColors.whiteColor,
                      weight: FontWeight.bold,
                    )),
              ],
            );
          },
        ),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: carouselItems.length,
          effect: const WormEffect(
            dotHeight: 5,
            dotWidth: 8,
            spacing: 8,
            dotColor: Colors.grey,
            activeDotColor: AppColors.orange
          ),
        ),
      ],
    );
  }
}
