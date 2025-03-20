// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:picknow/views/widgets/custombutton.dart';
import 'package:picknow/views/widgets/customtext.dart';
import '../../core/costants/navigation/navigation.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../core/services/pincode/pincode_service.dart';

class AddressScreen extends StatefulWidget {
  final String currentAddress;
  final bool isfromhome;

  const AddressScreen(this.currentAddress, this.isfromhome, {super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _showAddressForm = false;
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _houesnoController = TextEditingController();
  final TextEditingController _colornyController = TextEditingController();

  @override
  void initState() {
    _pincodeController.addListener(_fetchCityState);
    super.initState();
  }

  @override
  void dispose() {
    _pincodeController.removeListener(_fetchCityState);
    _pincodeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _houesnoController.dispose();
    _colornyController.dispose();
    super.dispose();
  }

  Future<void> _fetchCityState() async {
    final pincode = _pincodeController.text;

    // Only make the API call if the pincode is 6 digits (for India)
    if (pincode.length == 6) {
      try {
        final result = await PincodeService.getCityState(pincode);
        setState(() {
          // Update the city and state controllers with fetched data
          _cityController.text = result['city'] ?? 'Not found';
          _stateController.text = result['state'] ?? 'Not found';
        });
      } catch (e) {
        setState(() {
          _cityController.text = 'Error';
          _stateController.text = 'Error';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Clear the city and state if the pincode is not valid
      setState(() {
        _cityController.clear();
        _stateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isfromhome ? AppBar( automaticallyImplyLeading: false,
          leading:  IconButton(
                onPressed: () {
                  PageNavigations().pop();
                },
                icon: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.lightgrey),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ))),
          title:CustomText(text: 'My Addresses', size: 0.035, color: AppColors.blackColor),
          centerTitle: true,) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: AppColors.orange, size: 30),
                    SizedBox(height: 10),
                    Text(
                      "Current Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(widget.currentAddress,
                        style: TextStyle(fontSize: 16, color: Colors.black87)),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        widget.isfromhome
                        ? SizedBox.shrink()
                       : Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Address Selected")),
                              );
                            },
                            icon: Icon(Icons.check,color: AppColors.whiteColor,),
                            label: Text("Use This Address"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showAddressForm = !_showAddressForm;
                              });
                            },
                            icon: Icon(Icons.add_location_alt,
                                color: AppColors.orange),
                            label: Text("Add New Address"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.orange,
                              side: BorderSide(color: AppColors.orange),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Address Form (Only shown when "Add New Address" is tapped)
              if (_showAddressForm) buildAddressForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter New Address",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          buildTextField(
              "Full Name", TextInputType.text, _nameController),
          SizedBox(height: 10),
          buildTextField("Phone Number",TextInputType.phone,
              _phoneController),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: buildTextField("Pincode",
                      TextInputType.number, _pincodeController)),
              SizedBox(width: 10),
              Expanded(
                  child: buildTextField("District",
                      TextInputType.text, _cityController)),
            ],
          ),
          SizedBox(height: 10),
          buildTextField(
              "State", TextInputType.text, _stateController),
          SizedBox(height: 10),
          buildTextField("House No.,Building Name", 
              TextInputType.streetAddress, _houesnoController,
              maxLines: 2),
          SizedBox(height: 10),
          buildTextField("Road Name,Area,Colony",
              TextInputType.text, _colornyController,
              maxLines: 2),
          SizedBox(height: 10),
          SizedBox(height: 20),
          Center(
            child: CustomElevatedButton(
              onPressed: () {},
              text: "Save Address",
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextInputType keyboardType,
      TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      cursorColor: AppColors.grey,
      controller: controller,
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
}


