import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/data_controller.dart';
import 'package:radeef/models/User/message_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/need_help_screen.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  RxList<Message> messages = <Message>[].obs;

  var chatId = "".obs;
  final SocketService _socketService = SocketService();

  final _dataController = Get.put(DataController());

    @override
  void onInit() {
    super.onInit();
    listenForMessages();
  }

  Future<void> createChatRoom({required String userId}) async {
    final body = {"user_id": userId};

    final response = await ApiClient.postData("/inbox/new-chat", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      chatId.value = response.body['id'];
      debugPrint("Chat ID=========>: ${chatId.value}");
      Get.to(() => NeedHelpScreen(chatId: chatId.value));
    } else {
      debugPrint("Something went wrong");
    }
  }

  Future<void> fetchMessages({required String chatId}) async {
    isLoading.value = true;

    final response = await ApiClient.getData("/messages?chat_id=$chatId");

    if (response.statusCode == 200) {
      final json = response.body;
      final model = MessageModel.fromJson(json);
      messages.value = model.data;
    } else {
      debugPrint("Failed to load messages");
    }

    isLoading.value = false;
  }

  void sendMessage({
    required String chatId,
    required String text,
    List<String>? mediaUrls,
  }) {
    if (text.trim().isEmpty) return;

    final body = {
      "chat_id": chatId,
      "text": text,
      "media_urls": mediaUrls ?? [],
    };

    /// correct event
    _socketService.emit("message:send", data: body);

    /// Optimistic UI
    messages.add(
      Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        chatId: chatId,
        userId: _dataController.id.value,
        text: text,
        mediaUrls: mediaUrls ?? [],
        isDeleted: false,
        seenBy: [],
        isMine: true,
      ),
    );
  }

void listenForMessages() {
  _socketService.on("message:new", (data) {
    final message = Message.fromJson(data);

    final exists = messages.any((m) => m.id == message.id);
    if (!exists) {
      messages.add(message);
    }
  });
}

}
