import 'dart:convert';

import 'package:chat_app/constants/config.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_in_list.dart';
import 'package:chat_app/models/user.dart';
import 'package:http/http.dart' as http;

class MyHttp {
  // chat
  static Future<List<ChatInList>> fetchChatList(String id) {
    var queryString = Uri(queryParameters: {'id': id}).query;
    return http
        .get(Uri.parse(
            '$BACKEND_DOMAIN/chat/listChatForListDisplay?$queryString'))
        .then((res) {
      if (res.statusCode == 200) {
        List<ChatInList> list = [];
        var resJson = jsonDecode(res.body);
        resJson['payload'].forEach((item) {
          list.add(ChatInList.fromJson(item));
        });
        return list;
      } else {
        throw Exception('Failed to load chat list');
      }
    });
  }

  static Future<Chat> fetchChatByMemberIds(List memberIds) async {
    Chat chat;
    var response = await http.post(
        Uri.parse(
            '$BACKEND_DOMAIN/chat/getChatInfoByUserIdsOrCreateIfNotExist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'ids': memberIds,
        }));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      chat = Chat.fromJson(json['payload']);
    } else {
      throw Exception('Failed to load chat');
    }
    return chat;
  }

  static Future<Chat> fetchChatById(String id) async {
    Chat chat;
    var queryString = Uri(queryParameters: {'id': id}).query;
    var response = await http
        .get(Uri.parse('$BACKEND_DOMAIN/chat/getChatById?$queryString'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      chat = Chat.fromJson(json['payload']);
    } else {
      throw Exception('Failed to load chat');
    }
    return chat;
  }

  static Future<ChatInList> fetchBriefChatById(String id) async {
    ChatInList item;
    var queryString = Uri(queryParameters: {'id': id}).query;
    var res = await http
        .get(Uri.parse('$BACKEND_DOMAIN/chat/getBriefItemById?$queryString'));
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      item = ChatInList.fromJson(json['payload']);
    } else
      throw ('failed to fetch brief chat');
    return item;
  }

  // user
  static Future<List<User>> fetchAllUser() async {
    List<User> list = [];
    var response =
        await http.get(Uri.parse('$BACKEND_DOMAIN/user/listUserWithParams'));
    if (response.statusCode == 200) {
      var jsonArr = jsonDecode(response.body);
      jsonArr.forEach((itemJsonObj) {
        list.add(User.fromJson(itemJsonObj));
      });
    } else {
      throw Exception('Failed to user list');
    }
    return list;
  }

  static Future<User> createUser(Map<String, String> userJson) async {
    var response = await http.post(
      Uri.parse('$BACKEND_DOMAIN/user/createNewUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userJson),
    );
    var resJson = jsonDecode(response.body);
    User user = User.fromJson(resJson['payload']);
    return user;
  }

  static Future<User> getOrCreateUserIfNotExist(Map<String, dynamic> userJson) async {
    var response = await http.post(
      Uri.parse('$BACKEND_DOMAIN/user/getOrCreateUserIfNotExist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userJson),
    );
    var resJson = jsonDecode(response.body);
    print(resJson);
    User user = User.fromJson(resJson['payload']);
    return user;
  }

  static Future<User> fetchUserByUid(String uid) async {
    User user;
    String queryString = Uri(queryParameters: {'uid': uid}).query;
    var response = await http
        .get(Uri.parse('$BACKEND_DOMAIN/user/getUserByUid?$queryString'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      user = User.fromJson(json['payload']);
    }else{
      throw 'failed to load user';
    }
    return user;
  }
}
