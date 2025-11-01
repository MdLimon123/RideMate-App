import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';

class RatePessengersScreen extends StatefulWidget {
  const RatePessengersScreen({super.key});

  @override
  State<RatePessengersScreen> createState() => _RatePessengersScreenState();
}

class _RatePessengersScreenState extends State<RatePessengersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22),
          children: [
            SizedBox(height: 162,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: const Color(0xFF345983),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/demo.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      "Sergio Romasis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 158,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/cycle.svg"),
                          const SizedBox(width: 4),
                          const Text(
                            "Trip",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF333333)),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF333333)),
                          ),
                          const SizedBox(width: 20),
                          const Icon(
                            Icons.star,
                            color: Color(0xFF012F64),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4.6",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF333333)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 34,),
                  Center(
                    child: Text("Rate the Passengers",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF)
                    ),),
                  ),
                  SizedBox(height: 16,),
                 Center(
          child: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Color(0xFFFFFFFF),
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        )


                ],
              ),
            ),
            SizedBox(height: 68,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Center(
                      child: Text("Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor
                      ),),
                    ),
                  ),
                ),
                SizedBox(width: 22,),
                Expanded(child: CustomButton(onTap: (){},
                    text: "Rate Now"))
              ],
            )

          ],
        ),
      ),
    );
  }
}
