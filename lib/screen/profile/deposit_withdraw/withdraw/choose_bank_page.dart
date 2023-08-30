import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/const/image_assets.dart';

import 'add_bank_account_page.dart';
import 'edit_bank_page.dart';
import 'widgets/bank_info_card_tile.dart';
import 'widgets/confirm_withdraw_bottomsheet_dialog.dart';
import 'widgets/custom_withdraw_appbar.dart';

class ChooseBankPage extends StatelessWidget {
  const ChooseBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomWithdrawAppBar(
        title: 'Chọn ngân hàng',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đã lưu',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.dark6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.to(const AddBankAccountPage()),
                  icon: const Icon(
                    Icons.add,
                    size: 32,
                    color: Color(0xFF404040),
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BankInfoCardTile(
                  imgPath: ImageAssets.icBank1,
                  bankName: 'Vietcombank',
                  bankStatus: 'Ngân hàng TMCP Ngoại thương Việt Nam',
                  accountNumber: 'Số tài khoản - 10335665233',
                  accountHolder: 'Chủ tài khoản - VŨ ANH TÙNG',
                  onTapBank: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return const ConfirmWithdrawBottomSheetDialog();
                      },
                    );
                  },
                  onTapEdit: () => Get.to(const EditBankPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
