import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gohomy/components/loading/loading_full_screen.dart';
import 'package:gohomy/model/contract.dart';
import 'package:gohomy/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../utils/debounce.dart';
import 'add_contract/add_contract_screen.dart';
import 'contract_controller.dart';

class ContractScreen extends StatefulWidget {
  ContractScreen({Key? key, this.isNext, this.initTab}) : super(key: key);
  bool? isNext;
  int? initTab;

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen>
    with SingleTickerProviderStateMixin {
  ContractController contractController = ContractController();

  RefreshController refreshController = RefreshController();

  late TabController _tabController;
  late DateTime startDate;
  late DateTime endDate;
  @override
  void initState() {
    if (widget.isNext == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Get.to(() => AddContractScreen())!.then(
            (value) => contractController.getAllContract(isRefresh: true));
      });
    }
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initTab ?? 0);
    if (widget.initTab != null) {
      contractController.status.value = widget.initTab == 0
          ? 0
          : widget.initTab == 1
              ? 2
              : 1;
      contractController.getAllContract(isRefresh: true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange, Colors.orange]),
            ),
          ),
          title: const Text('Hợp đồng'),
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SizedBox(
                          width: Get.width * 0.9,
                          height: Get.height * 0.5,
                          child: SfDateRangePicker(
                            onCancel: () {
                              Get.back();
                            },
                            onSubmit: (v) {
                              contractController.onOkChooseTime(
                                  startDate, endDate);

                              contractController.getAllContract(
                                  isRefresh: true);
                            },
                            showActionButtons: true,
                            onSelectionChanged: chooseRangeTime,
                            selectionMode: DateRangePickerSelectionMode.range,
                            initialSelectedRange: PickerDateRange(
                              contractController.fromDateOption,
                              contractController.toDateOption,
                            ),
                            maxDate: DateTime.now(),
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(
                  FontAwesomeIcons.calendar,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 45,
              width: Get.width,
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  onTap: (v) {
                    contractController.status.value = v == 0
                        ? 0
                        : v == 1
                            ? 2
                            : 1;
                    contractController.getAllContract(isRefresh: true);
                  },
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Đang chờ ký',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Còn hiệu lực',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Hết hiệu lực',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            SahaTextFieldSearch(
              hintText: "Tên, sđt người đại diện",
              onChanged: (v) {
                EasyDebounce.debounce(
                    'debounce_search_contract', const Duration(milliseconds: 300),
                    () {
                  contractController.textSearch = v;
                  contractController.getAllContract(isRefresh: true);
                });
              },
              onClose: () {
                contractController.textSearch = "";

                contractController.getAllContract(isRefresh: true);
              },
            ),
            Expanded(
              child: Obx(
                () => contractController.loadInit.value
                    ? SahaLoadingFullScreen()
                    : contractController.listContract.isEmpty
                        ? const Center(
                            child: Text('Không có hợp đồng'),
                          )
                        : SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: const MaterialClassicHeader(),
                            footer: CustomFooter(
                              builder: (
                                BuildContext context,
                                LoadStatus? mode,
                              ) {
                                Widget body = Container();
                                if (mode == LoadStatus.idle) {
                                  body = Obx(() =>
                                      contractController.isLoading.value
                                          ? const CupertinoActivityIndicator()
                                          : Container());
                                } else if (mode == LoadStatus.loading) {
                                  body = const CupertinoActivityIndicator();
                                }
                                return SizedBox(
                                  height: 100,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: refreshController,
                            onRefresh: () async {
                              await contractController.getAllContract(
                                  isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await contractController.getAllContract();
                              refreshController.loadComplete();
                            },
                            child: SingleChildScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: contractController.listContract
                                    .map((e) => itemContract(e))
                                    .toList(),
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddContractScreen())!.then((value) => {
                  if (value == 'create_success')
                    {
                      _tabController.animateTo(0),
                      contractController.status.value = 0,
                    },
                  contractController.getAllContract(isRefresh: true)
                });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemContract(Contract contract) {
    return InkWell(
      onTap: () {
        Get.to(() => AddContractScreen(
                  contractId: contract.id,
                  ignoring: contract.status == 1 ? true : false,
                  isUser: false,
                ))!
            .then((value) =>
                {contractController.getAllContract(isRefresh: true)});
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Đại diện thuê:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " ${(contract.listRenter ?? []).where((e) => e.isRepresent == true).toList().isEmpty ? "" : (contract.listRenter ?? []).where((e) => e.isRepresent == true).toList()[0].name ?? ""}",
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Số điện thoại: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " ${(contract.listRenter ?? []).where((e) => e.isRepresent == true).toList().isEmpty ? "" : (contract.listRenter ?? []).where((e) => e.isRepresent == true).toList()[0].phoneNumber ?? ""}",
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tiền hợp đồng:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${SahaStringUtils().convertToMoney(contract.money ?? 0)} VNĐ",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const Divider(),
                if (contract.motelRoom?.towerId != null)
                  Container(
                     margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Toà nhà:",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: Get.width / 2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                contract.motelRoom?.towerName ?? "",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          
                          ],
                        ),
                      
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nhà trọ:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: Get.width / 2,
                      alignment: Alignment.centerRight,
                      child: Text(
                        contract.motelRoom?.motelName ?? "",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Số điện thoại chủ trọ:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        contract.motelRoom?.phoneNumber ?? "",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.peopleRoof,
                            color: Color(0xFF00B894),
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${contract.motelRoom?.capacity ?? ""}",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            contract.motelRoom?.sex == 0
                                ? FontAwesomeIcons.marsAndVenus
                                : contract.motelRoom?.sex == 1
                                    ? FontAwesomeIcons.mars
                                    : FontAwesomeIcons.venus,
                            color: contract.motelRoom?.sex == 0
                                ? const Color(0xFFBDC3C7)
                                : contract.motelRoom?.sex == 1
                                    ? const Color(0xFF2980B9)
                                    : const Color(0xFFE84393),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            contract.motelRoom?.sex == 0
                                ? "Nam, Nữ"
                                : contract.motelRoom?.sex == 1
                                    ? "Nam"
                                    : "Nữ",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.house,
                            color: Color(0xFFFDCB6E),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${contract.motelRoom?.area ?? ""}m²"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (contract.status == 3)
            Positioned(
              top: 20,
              child: Container(
                width: Get.width / 4,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12)),
                transform: Matrix4.rotationZ(0.2),
                child: const Center(
                  child: Text(
                    'Đã đặt coc',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  bool isNumericUsingTryParse(String string) {
    // Null or empty string is not a number
    if (string.isEmpty) {
      return false;
    }

    // Try to parse input string to number.
    // Both integer and double work.
    // Use int.tryParse if you want to check integer only.
    // Use double.tryParse if you want to check double only.
    final number = int.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }
}
