class MessageModel {
  final Meta? meta;
  final List<Message> data;

  MessageModel({this.meta, required this.data});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: (json['data'] as List<dynamic>)
          .map((e) => Message.fromJson(e))
          .toList(),
    );
  }
}

class Meta {
  final Pagination? pagination;

  Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }
}

class Message {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String chatId;
  final String? parentId;
  final String userId;
  final String text;
  final List<String> mediaUrls;
  final bool isDeleted;
  final List<String> seenBy;
  final bool isMine;

  Message({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.chatId,
    this.parentId,
    required this.userId,
    required this.text,
    required this.mediaUrls,
    required this.isDeleted,
    required this.seenBy,
    required this.isMine,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      chatId: json['chat_id'],
      parentId: json['parent_id'],
      userId: json['user_id'],
      text: json['text'],
      mediaUrls: List<String>.from(json['media_urls'] ?? []),
      isDeleted: json['isDeleted'] ?? false,
      seenBy: List<String>.from(json['seen_by'] ?? []),
      isMine: json['is_mine'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'chat_id': chatId,
      'parent_id': parentId,
      'user_id': userId,
      'text': text,
      'media_urls': mediaUrls,
      'isDeleted': isDeleted,
      'seen_by': seenBy,
      'is_mine': isMine,
    };
  }
}


