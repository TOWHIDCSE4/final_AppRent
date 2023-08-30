import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/arlert/saha_alert.dart';
import 'package:gohomy/data/repository/repository_manager.dart';

import '../../../model/post_find_room.dart';

class PostFindRoomController extends GetxController {
  var post = PostFindRoom().obs;
  String? linkPost;
  var loadInit = false.obs;
  int postFindRoomId;
  PostFindRoomController({required this.postFindRoomId}) {
    getPostFindRoom();
  }
  Future<void> getPostFindRoom() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.userManageRepository
          .getPostFindRoom(idPostFindRoom: postFindRoomId);
      post.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }


  Future<void> callFindRoom() async {
    try {
      var res = await RepositoryManager.roomPostRepository
          .callFindRoom(id: postFindRoomId);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> buildLink() async {
    try {
      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse("https://rencity.page.link/findroom/$postFindRoomId"),
        uriPrefix: "https://rencity.page.link",
        androidParameters:
            const AndroidParameters(packageName: "com.ikitech.rencity"),
        iosParameters: const IOSParameters(bundleId: "com.ikitech.rencity",appStoreId: "6443961326"),
      );
      final dynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      print(dynamicLink.shortUrl);
        linkPost = dynamicLink.shortUrl.toString();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
