import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:picknow/core/costants/mediaquery/mediaquery.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
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

  // Sample data - replace with your own images and texts
  final List<Map<String, String>> carouselItems = [
    {
      "image":
          "https://sindhidryfruits.live/cdn/shop/articles/The_Best_Dry_Fruits_for_Energy_A_Look_at_Nutrient-Rich_Powerhouses.png?v=1693213059",
      "text": "Welcome to Our App",
    },
    {
      "image":
          "https://lh5.googleusercontent.com/proxy/sO9mLL8g4ur3ClhP9SPsNCfzD3VNagFIHP6w6STlFANHTPvptXlWz0imh3dQa492xaTwZmCN_1s7Y02Q28psY43Gyo7vzPrBeppPn9ZqPZ-Kljm29CQr28__",
      "text": "Discover Amazing Products",
    },
    {
      "image":
          "https://media.istockphoto.com/id/598241944/photo/honey-in-jar-and-bunch-of-dry-lavender.webp?b=1&s=612x612&w=0&k=20&c=dFdIOtzku7KAwjVjRKVxB7fXu2vdxDXkgGU5JMPE9UA=",
      "text": "Start Your Journey",
    },
     {
      "image":
          "https://www.orgoallnatural.com/blog/wp-content/uploads/2023/03/Handmade-Soaps-Benefits.webp",
      "text": "Start Your Journey",
    },
     {
      "image":
          "https://mylaporeganapathys.com/wp-content/uploads/2017/10/mixed-pickle.jpg",
      "text": "Start Your Journey",
    },
     {
      "image":
          "https://www.shutterstock.com/image-photo/legumes-lentils-chickpea-beans-assortment-260nw-1960506445.jpg",
      "text": "Start Your Journey",
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
            height: mediaqueryheight(0.3, context),
           
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
                    top: 160,
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
        const SizedBox(height: 4),
        // Smooth Page Indicator
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: carouselItems.length,
          effect: const WormEffect(
            // You can change this to different effects
            dotHeight: 5,
            dotWidth: 8,
            spacing: 8,
            dotColor: Colors.grey,
            activeDotColor: AppColors.orange
            // paintStyle: PaintingStyle.stroke,  // Uncomment for outlined dots
          ),
        ),
      ],
    );
  }
}
