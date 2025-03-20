
import 'package:flutter/material.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/widgets/customtext.dart';

class AllOrders extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const AllOrders({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return OrderWidget(
          image: product["image"],
          delivery: product["delivery"],
          name: product['name'],
          isdelivered: product["isdelivered"],
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Divider(),
      ),
    ));
  }
}

class OrderWidget extends StatefulWidget {
  final String name;
  final String delivery;
  final String image;
  final bool isdelivered;

  const OrderWidget(
      {super.key,
      required this.delivery,
      required this.image,
      required this.name,
      required this.isdelivered});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isReviewVisible = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.delivery,
                      size: 0.035,
                      color: AppColors.blackColor,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: widget.name,
                      size: 0.035,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.isdelivered == true
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = index + 1;
                              });
                            },
                            child: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 24,
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          '($_rating/5)',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    // Review Button
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isReviewVisible = !_isReviewVisible;
                        });
                      },
                      child: Text(
                        _isReviewVisible ? 'Hide Review' : 'Write a Review',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Review Text Field
                    if (_isReviewVisible) ...[
                      TextField(
                        controller: _reviewController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Write your review here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review submitted successfully!'),
                            ),
                          );
                          setState(() {
                            _isReviewVisible = false;
                            _reviewController.clear();
                          });
                        },
                        child: const Text('Submit Review'),
                      ),
                    ],
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
