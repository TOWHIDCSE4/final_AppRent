import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/banners.dart';

class BannerManageController extends GetxController {
  var listBanner = RxList<Banners>();
  int currentPage = 1;
  bool isEnd = false;
  var loadInit = true.obs;
  var isLoading = false.obs;

  BannerManageController() {
    getAllBanner(isRefresh: true);
  }
  Future<void> getAllBanner({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.adminManageRepository.getAllBanner();

        if (isRefresh == true) {
          listBanner(data!.data!);
        } else {
          listBanner.addAll(data!.data!);
        }

        // if (data.data!.nextPageUrl == null) {
        //   isEnd = true;
        // } else {
        //   isEnd = false;
        //   currentPage = currentPage + 1;
        // }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
