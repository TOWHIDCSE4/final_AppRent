import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_widget.dart';
import 'package:gohomy/const/color.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/withdraw_history_model.dart';

import '../data/deposit_withdraw_repository.dart';
import 'history_card_tile.dart';

class WithdrawHistoryTile extends StatefulWidget {
  const WithdrawHistoryTile({
    super.key,
  });

  @override
  State<WithdrawHistoryTile> createState() => _WithdrawHistoryTileState();
}

class _WithdrawHistoryTileState extends State<WithdrawHistoryTile> {
  bool isLoading = true;
  List<Withdraw> withdrawInfo = [];

  @override
  void initState() {
    getDepositInfo();
    super.initState();
  }

  Future<void> getDepositInfo() async {
    var data = await DepositWithDrawRepository.instance.getWithdrawHistory();
    setState(() {
      withdrawInfo = data;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SahaLoadingWidget()
        : ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        var withdraw = withdrawInfo[index];
        return HistoryCardTile(
          amount: withdraw.withdrawMoney.toString(),
          amountColor: AppColor.red,
          from: 'Từ: ${withdraw.bankAccountHolderName}',
          content: 'ND: ${withdraw.withdrawContent}',
          dateTime: withdraw.withdrawDateTime,
        );
      },
    );
  }
}