import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/models/message_model.dart';

class NeedHelpScreen extends StatefulWidget {
  const NeedHelpScreen({super.key});

  @override
  State<NeedHelpScreen> createState() => _NeedHelpScreenState();
}

class _NeedHelpScreenState extends State<NeedHelpScreen> {

  final List<MessageModel> messages = [
    MessageModel(text: "Good Evening!", isSender: false, time: "8:29 pm"),
    MessageModel(text: "Welcome to Car2go Customer Service", isSender: false, time: "8:29 pm"),
    MessageModel(text: "Thank you!", isSender: true, time: "8:30 pm"),
    MessageModel(text: "How can I help you?", isSender: false, time: "8:31 pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios,
              color: Color(0xFF676769),),
            ),
            SizedBox(width: 12,),
            Text("Need Help",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333)
            ),),
            Spacer(),
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE6EAF0)
              ),
              child: SvgPicture.asset("assets/icons/phone.svg"),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment:
                      message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!message.isSender) ...[

                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFF10B981),
                              width: 1),
                              image: DecorationImage(image: AssetImage('assets/images/demo.png'),
                              fit: BoxFit.cover)
                            ),
                          ),

                          SizedBox(width: 12),
                        ],
                        Flexible(
                          child: Column(
                            crossAxisAlignment: message.isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: message.isSender ? Color(0xFFE6EAF0) : Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(message.isSender ? 12 : 0),
                                    topRight: Radius.circular(message.isSender ? 0 : 12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  message.text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF0D1A3E),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                message.time,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF676769),
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (message.isSender) SizedBox(width: 8),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF545454),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF545454),width: 1)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF545454),width: 1)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF545454),width: 1)
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/icons/emoji.svg'),
                      )
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                SvgPicture.asset('assets/icons/send.svg')

              ],
            )
          ],
        ),
      ),
    );
  }
}
