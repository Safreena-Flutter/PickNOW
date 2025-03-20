
import 'package:flutter/material.dart';

import '../../../core/costants/theme/appcolors.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final double rating;
  final String comment;
  final String date;

  const ReviewCard({
    super.key,
    required this.username,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
  children: List.generate(5, (index) {

    if (index < rating.floor()) {
      // Full star
      return Icon(Icons.star, color: Colors.amber, size: 16);
    } else if (index < rating) {
      // Half star
      return Icon(Icons.star_half, color: Colors.amber, size: 16);
    } else {
      // Empty star
      return Icon(Icons.star_border, color: Colors.amber, size: 16);
    }
  }),
),

            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
           
            Text(comment),
          ],
        ),
      ),
    );
  }
}

  Widget buildExpandableSection({
  required String title,
  required IconData icon,
  required bool isExpanded,
  required VoidCallback onTap,
  required Widget child,
}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey, size: 20),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
      AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        firstChild: Container(), // Collapsed state
        secondChild: Padding(
          padding: EdgeInsets.only(top: 10),
          child: child,
        ),
      ),
    ],
  );
}
class ExpandableProductDetails extends StatefulWidget {
  const ExpandableProductDetails({super.key});

  @override
  State<ExpandableProductDetails> createState() =>
      _ExpandableProductDetailsState();
}

class _ExpandableProductDetailsState extends State<ExpandableProductDetails> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Product Details',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(_isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded),
            ),
          ],
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, 
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
