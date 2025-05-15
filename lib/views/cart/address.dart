// ignore_for_file: use_build_context_synchronously, constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picknow/views/cart/widget/address_form.dart';
import 'package:picknow/views/widgets/custombutton.dart';
import 'package:provider/provider.dart';
import '../../core/costants/theme/appcolors.dart';
import '../../core/services/pincode/pincode_service.dart';
import '../../model/address/address.dart';
import '../../providers/cart/address_provider.dart';
import '../../providers/profile/userprofile_provider.dart';

class AddressScreen extends StatefulWidget {
  final bool isFromHome;
  final Function(Address)? onAddressSelected;

  const AddressScreen(
    this.isFromHome, {
    this.onAddressSelected,
    super.key,
  });

  @override
  _AddressScreenState createState() => _AddressScreenState();
}


enum AddressType { Home, Work }

class _AddressScreenState extends State<AddressScreen> {
  bool _showAddressForm = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _colonyController = TextEditingController();

  AddressType _selectedAddressType = AddressType.Home;
  String? _selectedAddressId;

  @override
  void initState() {
    _pincodeController.addListener(_fetchCityState);
    super.initState();

    Future.delayed(Duration.zero, () {
      final userProvider = Provider.of<ProfileProvider>(context, listen: false);
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      if (userProvider.user != null) {
        _nameController.text = userProvider.user!.name;
        _phoneController.text = userProvider.user!.contact;
      }
      addressProvider.loadAddresses();
    });
  }

  @override
  void dispose() {
    _pincodeController.removeListener(_fetchCityState);
    _pincodeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _colonyController.dispose();
    super.dispose();
  }

  Future<void> _fetchCityState() async {
    if (_pincodeController.text.length == 6) {
      try {
        final result =
            await PincodeService.getCityState(_pincodeController.text);
        setState(() {
          _stateController.text =
              "${result['city'] ?? 'Not found'}, ${result['state'] ?? 'Not found'}, ${result['country'] ?? 'Not found'}";
        });
      } catch (e) {
        setState(() {
          _cityController.clear();
          _stateController.clear();
        });
      }
    }
  }

  void _toggleAddressForm() {
    setState(() {
      _showAddressForm = !_showAddressForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: widget.isFromHome
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              title: Text('My Addresses'),
              centerTitle: true,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_showAddressForm) ...[
                Card(
                  color: AppColors.frost,
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: _toggleAddressForm,
                  ),
                ),

                SizedBox(height: 20),

                // Saved Addresses
                Text("Saved Addresses",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                addressProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: addressProvider.addresses.map((address) {
                          return RadioListTile<String>(
                            title: Text(address.name ?? ''),
                            subtitle: Text(
                                "${address.address}, ${address.city}, ${address.state}, ${address.country} - ${address.pincode}"),
                            value: address.id,
                            groupValue: _selectedAddressId,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedAddressId = value;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Selected ${address.address}")));
                            },
                            activeColor: Colors.green,
                          );
                        }).toList(),
                      ),
              ],

              // Address Form
              if (_showAddressForm) buildAddressForm(addressProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressForm(AddressProvider addressprovider) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter New Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Full Name Field
            buildTextField(
              "Full Name",
              TextInputType.text,
              _nameController,
            ),
            SizedBox(height: 10),

            // Phone Number Field
            buildTextField(
              "Phone Number",
              TextInputType.phone,
              _phoneController,
            ),
            SizedBox(height: 10),

            // Pincode & District Fields
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                      "Pincode", TextInputType.number, _pincodeController),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: buildTextField(
                      "City", TextInputType.text, _cityController),
                ),
              ],
            ),
            SizedBox(height: 10),

            buildTextField(
                "District, State", TextInputType.text, _stateController),
            SizedBox(height: 10),

            buildTextField(
              "Street, Road Name, Area, Colony",
              TextInputType.text,
              _colonyController,
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<AddressType>(
                  value: AddressType.Work,
                  groupValue: _selectedAddressType,
                  fillColor: WidgetStateProperty.all(AppColors.orange),
                  onChanged: (AddressType? value) {
                    setState(() {
                      _selectedAddressType = value!;
                    });
                  },
                ),
                Text("Work"),
                SizedBox(width: 10),
                Radio<AddressType>(
                  value: AddressType.Home,
                  groupValue: _selectedAddressType,
                  fillColor: WidgetStateProperty.all(AppColors.orange),
                  onChanged: (AddressType? value) {
                    setState(() {
                      _selectedAddressType = value!;
                    });
                  },
                ),
                Text("Home"),
              ],
            ),

            SizedBox(height: 20),

            // Save Address Button
            Center(
                child: addressprovider.isPosting
                    ? CircularProgressIndicator()
                    : CustomElevatedButton(
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Address newAddress = Address(
                              type: _selectedAddressType.name,
                              street: _colonyController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              pincode: _pincodeController.text,
                              country: 'India',
                            );
                            addressprovider.submitAddress(newAddress);
                            if (widget.onAddressSelected != null) {
      widget.onAddressSelected!(newAddress);
    }
                          }
                        },
                        text: 'Submit Address')),
          ],
        ),
      ),
    );
  }
}
