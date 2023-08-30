import 'package:get/get.dart';
import 'package:gohomy/model/contract.dart';
import 'package:intl/intl.dart';

import '../../../components/arlert/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class ContractUserController extends GetxController {
  var listContract = RxList<Contract>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  DateTime? fromDateOption;
  DateTime? toDateOption;
  var checkSelected = false.obs;
  String? dateFrom;
  String? dateTo;

  ContractUserController() {
    getAllContractUser(isRefresh: true);
  }

  Future<void> getAllContractUser({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.userManageRepository
            .getAllContractUser(
                search: textSearch,
                page: currentPage,
                status: status.value,
                dateFrom: dateFrom,
                dateTo: dateTo);

        if (isRefresh == true) {
          listContract(data!.data!.data!);
        } else {
          listContract.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteContract({required int contractId}) async {
    try {
      var data = await RepositoryManager.manageRepository
          .deleteContract(contractId: contractId);
      listContract.removeWhere((element) => contractId == element.id);
      Get.back();
      SahaAlert.showSuccess(message: "Đã xoá dịch vụ");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  void onOkChooseTime(DateTime startDate, DateTime endDate) {
    checkSelected.value = true;
    fromDay.value = startDate;
    toDay.value = endDate;
    fromDateOption = startDate;
    toDateOption = endDate;
    dateFrom = DateFormat('yyyy-MM-dd').format(startDate);
    dateTo = DateFormat('yyyy-MM-dd').format(endDate);
    Get.back();
  }
}
