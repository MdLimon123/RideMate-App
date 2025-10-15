import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/views/base/custom_button.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 164,),
            Center(child: SvgPicture.asset("assets/icons/ride.svg")),
            SizedBox(height: 16,),
            Center(child: Text("Ride. Earn. Go Further",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333)
            ),),),
            SizedBox(height: 12,),
            Text("Book quick rides or start earning on your own schedule - Assurance, Speed, and Precision",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF545454)
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 258,),
            CustomButton(onTap: (){}, text: "User Account"),
            SizedBox(height: 16,),
            Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE6EAF0),
                borderRadius: BorderRadius.circular(24)
              ),
              child: Center(
                child: Text("Drivers Account",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF545454)
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
