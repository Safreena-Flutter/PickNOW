import 'package:flutter/material.dart';
import 'package:picknow/core/costants/navigation/navigation.dart';
import 'package:picknow/model/address/address.dart';
import 'package:picknow/providers/cart/order.dart';
import 'package:picknow/views/bottombar/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final Address selectedAddress;
  final num total;
  const PaymentScreen({super.key, required this.selectedAddress,required this.total});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);
  _handlePaymentSuccess(response, orderProvider);
});

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Automatically open payment
    Future.delayed(Duration.zero, () {
      _openCheckout();
    });
  }

  void _openCheckout() {
    print('## ${widget.total}');
    var options = {
      'key': 'rzp_live_MigiyKCfLulpBY',
      'amount': widget.total * 100 , // Replace with actual total
      'name': 'PickNow',
      'description': 'Payment for Order',
      'prefill': {
        'contact': '9876543210', // You can use user mobile
        'email': 'user@example.com', // User email if available
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

 void _handlePaymentSuccess(PaymentSuccessResponse response,OrderProvider orderProvider) async {

  bool success = await orderProvider.placeOrder(
    widget.selectedAddress, // you're already passing address to PaymentScreen
    response.paymentId ?? '',
    "Please deliver in the evening",
  );

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Order placed successfully!"),
      behavior: SnackBarBehavior.floating,
    ));
PageNavigations().push(BottomBar());
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Order failed. Try again!"),
      behavior: SnackBarBehavior.floating,
    ));
  }
}


  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Payment Failed! Please try again."),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(), // You can change UI here
      ),
    );
  }
}
