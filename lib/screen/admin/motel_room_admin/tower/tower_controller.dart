import 'package:get/get.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/tower.dart';

class TowerController extends GetxController {
  var listTower = RxList<Tower>();
  int currentPage = 1;

  bool isEnd = false;
  var loadInit = true.obs;

  var isLoading = false.obs;

  TowerController() {
    // userChoose.value = Get.find<DataAppController>().currentUser.value;
    // if (userChoose.value.id ==
    //     Get.find<DataAppController>().currentUser.value.id) {
    //   userChoose.value.name = 'Admin';
    // }
    getAllTower(isRefresh: true);
  }

  Future<void> getAllTower({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.manageRepository.getAllTower(
          page: currentPage,
        );

        if (isRefresh == true) {
          listTower(data!.data!.data!);
          listTower.refresh();
        } else {
          listTower.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteTower({required int towerId}) async {
    try {
      var res = await RepositoryManager.manageRepository
          .deleteTower(towerId: towerId);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
