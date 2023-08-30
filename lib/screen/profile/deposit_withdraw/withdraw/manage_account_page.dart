import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/withdraw/widgets/custom_withdraw_appbar.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/custom_textfiield.dart';
import 'package:gohomy/screen/profile/profile_details/personal_information/widgets/text_field_title.dart';
import 'package:gohomy/screen/profile/profile_details/widget/custom_button.dart';

import 'manage_account_otp_page.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});

  @override
  State<ManageAccountPage> createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomWithdrawAppBar(
        title: 'Quản lý tài khoản nhận tiền',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldTextTitle(title: 'Ngân hàng'),
                CustomTextFiled(
                  textEditingController: phoneController,
                  hintText: 'ACB - Ngân hàng TMCP Á Châu',
                  backgroungColor: AppColor.light2,
                ),
                const TextFieldTextTitle(title: 'Số tài khoản'),
                CustomTextFiled(
                  textEditingController: emailController,
                  hintText: '123456789',
                  keyboardType: TextInputType.number,
                ),
                const TextFieldTextTitle(title: 'Chủ tài khoản'),
                CustomTextFiled(
                  textEditingController: jobController,
                  hintText: 'Nguyễn Thế Kiên',
                ),
                SizedBox(height: size.height * 0.25),
                CustomButton(
                  title: 'Tiếp tục',
                  bgColor: AppColor.primaryColor,
                  // width: size.width * 0.85,
                  onTap: () {
                    Get.to(const ManageAccountOTPPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
