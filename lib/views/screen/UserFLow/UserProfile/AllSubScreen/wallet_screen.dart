import 'package:flutter/material.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Wallet",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            width: double.infinity,
            height: 191,
            decoration: BoxDecoration(
              color: Color(0xFFE6EAF0),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Center(
              child: Text(" + 47.80 XAF",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Color(0xFF012F64)
              ),),
            ),
          ),
          SizedBox(height: 16,),
          Container(
            width: double.infinity,
            height: 110,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF545454)
                ),),
                SizedBox(height: 10,),
                CustomTextField(
                  filColor: Color(0xFFFFFFFF),
                  hintText: "20",
                )
              ],
            ),
          ),
          SizedBox(height: 112,),
          CustomButton(onTap: (){},
              text: "Proceed")
        ],
      ),
    );
  }
}
