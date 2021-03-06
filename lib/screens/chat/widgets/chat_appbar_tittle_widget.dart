import 'package:chat_app/common/Helper.dart';
import 'package:chat_app/constants/controllers.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/widgets/error_message_widget.dart';
import 'package:chat_app/widgets/my_circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatAppBarTitleWidget extends StatelessWidget {
  ChatAppBarTitleWidget({Key? key}) : super(key: key);
  final _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // loading
        if (_chatController.isLoading.value)
          return ListTile(
            leading: MyCircleAvatarWidget(
              username: "",
            ),
          );

        // success
        if (_chatController.error == null) {
          User friend = _chatController.chat.value!.members
              .singleWhere((item) => item.id != authController.user.value!.id);
          return ListTile(
            leading: MyCircleAvatarWidget(
              imageUrl: friend.avatarUrl,
              username: friend.username,
            ),
            title: Text(friend.username,
                style: Theme.of(context).primaryTextTheme.headline6),
            subtitle: buildLastSeen(friend),
          );
        }

        // error
        return ErrorMessageWidget();
      },
    );
  }

  buildLastSeen(User friend) {
    return Builder(
      builder: (context) {
        return Text(Helper.toActiveTimeString(friend.lastActive),
            style: Theme.of(context).primaryTextTheme.subtitle2);
      },
    );
  }
}
