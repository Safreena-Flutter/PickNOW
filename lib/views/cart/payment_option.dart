

  import 'package:flutter/material.dart';
import 'package:picknow/core/costants/theme/appcolors.dart';
import 'package:picknow/views/widgets/customtext.dart';

Widget buildPaymentOptions(dynamic total) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Select Payment Method",
            size: 0.025,
            color: AppColors.blackColor,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 16),
          _buildPaymentOption(
            icon: Icons.account_balance,
            title: "UPI Payment",
            subtitle: "Pay using UPI",
          ),
          _buildPaymentOption(
            icon: Icons.credit_card,
            title: "Card Payment",
            subtitle: "Credit/Debit Card",
          ),
          _buildPaymentOption(
            icon: Icons.money,
            title: "Cash on Delivery",
            subtitle: "Pay when you receive",
          ),
          SizedBox(height: 20),
          // Price Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Price Details",
                    size: 0.025,
                    color: AppColors.blackColor,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount:"),
                      Text("₹${total.round()}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.orange),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Radio(
          value: title,
          groupValue: null,
          onChanged: (value) {},
          activeColor: AppColors.orange,
        ),
      ),
    );
  }