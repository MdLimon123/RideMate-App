import 'package:flutter/material.dart';
import 'package:radeef/views/base/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Notification",
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text("Payment confirm",
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
                 color: Color(0xFF012F64)
               ),) ,
                SizedBox(height: 4,),
                Text("Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF676769)
                ),),
                SizedBox(height: 8,),
                Text("15 min ago.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF676769)
                ),),
                SizedBox(height: 8,),
                Divider(
                  color: Color(0xFFE6E6E6),
                  height: 1,
                )
              ],
            );
          }, 
          separatorBuilder: (_,_)=> SizedBox(height: 10,),
          itemCount: 5),
    );
  }
}
