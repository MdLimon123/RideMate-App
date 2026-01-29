import 'package:flutter/material.dart';

class PaymentWatingScreen extends StatefulWidget {
  const PaymentWatingScreen({super.key});

  @override
  State<PaymentWatingScreen> createState() => _PaymentWatingScreenState();
}

class _PaymentWatingScreenState extends State<PaymentWatingScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 236),
              Center(child: Image.asset("assets/images/payment.png")),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Awaiting",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  "The passengers is reviewing the trip details before relapsing payment to wallet.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
