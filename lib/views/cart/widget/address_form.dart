
  import 'package:flutter/material.dart';
import 'package:picknow/costants/theme/appcolors.dart';

Widget buildTextField(String label, TextInputType keyboardType,
      TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      cursorColor: AppColors.grey,
      controller: controller,
      
      validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return '$label is required';
      }
      if (label == "Phone Number" && value.length != 10) {
        return 'Enter a valid 10-digit phone number';
      }
      if (label == "Pincode" && value.length != 6) {
        return 'Enter a valid 6-digit pincode';
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        
        labelText: label,
        labelStyle: TextStyle(color: AppColors.grey),
        border:
            OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3)),
          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      
    );
  }