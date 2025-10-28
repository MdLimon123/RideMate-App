import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_driver_screen.dart';

class SearchADriverScreen extends StatefulWidget {
  const SearchADriverScreen({super.key});

  @override
  State<SearchADriverScreen> createState() => _SearchADriverScreenState();
}

class _SearchADriverScreenState extends State<SearchADriverScreen> with TickerProviderStateMixin{

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _rotationController;

  late Animation<double> _xScale;
  late Animation<double> _yScale;
  late Animation<double> _rotation;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    /// Y-axis scale (faster 1s)
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    /// Rotation (slow, continuous)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _xScale = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(parent: _xController, curve: Curves.easeInOut),
    );

    _yScale = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(parent: _yController, curve: Curves.easeInOut),
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );



    /// 🕐 Simulate searching for a driver (e.g., 5 seconds)
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Get.to(()=> FindDriverScreen());
      }
    });

    super.initState();
  }


  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good morning",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF545454)
                        ),),
                      SizedBox(height: 5,),
                      Text("Alex",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF545454)
                        ),)
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/icons/notification.svg'),
                  SizedBox(width: 12,),
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage('assets/images/demo.png',),
                            fit: BoxFit.cover)
                    ),
                  )
                ],
              ),
              SizedBox(height: 24,),
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                
                      onTap: (){},
                      decoration: InputDecoration(
                          hint: Text("Aqua Tower, Mohakhali",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF676769)
                            ),),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/icons/pick.svg',),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                          filled: true,
                          fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24)
                
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                
                      onTap: (){},
                      decoration: InputDecoration(
                          hint: Text("Aqua Tower, Mohakhali",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF676769)
                            ),),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/icons/location.svg'),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFB5F5D7))
                          ),
                          filled: true,
                          fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24)
                
                      ),
                    ),
                    SizedBox(height: 32,),

                    Container(
                      height: 250,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF345983),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "28 XAF",
                                style: TextStyle(
                                  color: Color(0xFF012F64),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),


                          /// 🔥 Animated Search Icon
                          AnimatedBuilder(
                            animation: Listenable.merge(
                                [_xController, _yController, _rotationController]),
                            builder: (context, child) {
                              return Transform.scale(
                                scaleX: _xScale.value,
                                scaleY: _yScale.value,
                                child: Transform.rotate(
                                  angle: _rotation.value * 6.28319, // 2π radians
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.4),
                                          blurRadius: 30,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/search_fill.svg',
                              color: Colors.white,
                              width: 72,
                              height: 72,
                            ),
                          ),



                          const SizedBox(height: 15),

                          const Text(
                            "We’re searching a Driver\nfor you!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),

                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 75),
                    //   decoration: BoxDecoration(
                    //       color: Color(0xFF345983),
                    //       borderRadius: BorderRadius.circular(24)
                    //   ),
                    //   child: Center(
                    //     child: Text("28 XAF",
                    //       style: TextStyle(
                    //           fontSize: 50,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.white
                    //       ),),
                    //   ),
                    // ),
                    
                    SizedBox(height: 169,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                
                        children: [
                          SvgPicture.asset('assets/icons/what.svg'),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Need Help?",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF333333)
                                ),),
                              SizedBox(height: 10,),
                              Text("Chat with our support",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF333333)
                                ),)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
