
import 'package:sampark/Model/ChatModel.dart';
import 'package:sampark/Model/UserModel.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages;
  int? unReadMessNo;
  String? lastMessage;
  String? lastMessagesTimestamp;
  String? timestamp;

  ChatRoomModel({this.id, this.sender, this.receiver, this.messages, this.unReadMessNo, this.lastMessage, this.lastMessagesTimestamp, this.timestamp});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["sender"] is Map) {
      sender = json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    }
    if(json["receiver"] is Map) {
      receiver = json["receiver"] == null ? null : UserModel.fromJson(json["receiver"]);
    }
    if(json["messages"] is List) {
      messages = json["messages"] ?? [];
    }
    if(json["unReadMessNo"] is int) {
      unReadMessNo = json["unReadMessNo"];
    }
    if(json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if(json["lastMessagesTimestamp"] is String) {
      lastMessagesTimestamp = json["lastMessagesTimestamp"];
    }
    if(json["timestamp"] is String) {
      timestamp = json["timestamp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(sender != null) {
      _data["sender"] = sender?.toJson();
    }
    if(receiver != null) {
      _data["receiver"] = receiver?.toJson();
    }
    if(messages != null) {
      _data["messages"] = messages;
    }
    _data["unReadMessNo"] = unReadMessNo;
    _data["lastMessage"] = lastMessage;
    _data["lastMessagesTimestamp"] = lastMessagesTimestamp;
    _data["timestamp"] = timestamp;
    return _data;
  }
}

