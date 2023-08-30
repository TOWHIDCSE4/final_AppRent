import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import '../widget/custom_entry_textfield.dart';
import '../widget/tranaction_type.dart';
import 'choose_bank_page.dart';

class WithdrawEntryPage extends StatefulWidget {
  const WithdrawEntryPage({super.key});

  @override
  State<WithdrawEntryPage> createState() => _WithdrawEntryPageState();
}

class _WithdrawEntryPageState extends State<WithdrawEntryPage> {
  final withdrawController = TextEditingController();
  bool isTyping = false;

  @override
  void dispose() {
    withdrawController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: Get.back,
        ),
        title: const Text(
          'Rút tiền',
          style: TextStyle(color: Color(0xFF1A1A1A)),
        ),
        centerTitle: true,
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Divider(color: AppColor.dark5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nhập số tiền cần rút',
                        style: TextStyle(
                          color: AppColor.dark2,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            withdrawController.text = '25.000.000';
                            isTyping = true;
                          });
                        },
                        child: const Text(
                          'Tất cả',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomEntryTextField(
                    controller: withdrawController,
                    isTyping: isTyping,
                    hintText: 'Tối thiểu 50.000',
                    transactionType: TransactionType.withdraw,
                    onChanged: (text) {
                      setState(() {
                        isTyping = text.isNotEmpty;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Số dư khả dụng',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.dark5,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '25.000.000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.dark4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).viewInsets.vertical > 0
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  title: 'Tiếp tục',
                  radius: 4,
                  height: 48,
                  bgColor: isTyping ? AppColor.primaryColor : AppColor.light3,
                  onTap: () => Get.to(const ChooseBankPage()),
                ),
              )
            : null,
      ),
    );
  }
}
