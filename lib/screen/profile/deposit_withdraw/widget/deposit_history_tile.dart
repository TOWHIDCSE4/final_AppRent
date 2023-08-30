import 'package:flutter/material.dart';
import 'package:gohomy/components/loading/loading_widget.dart';

import '../data/deposit_withdraw_repository.dart';
import '../domain/deposit_history_model.dart';
import 'history_card_tile.dart';

class DepositHistoryTile extends StatefulWidget {
  const DepositHistoryTile({
    super.key,
  });

  @override
  State<DepositHistoryTile> createState() => _DepositHistoryTileState();
}

class _DepositHistoryTileState extends State<DepositHistoryTile> {
  bool isLoading = true;
  List<Deposit> depositInfo = [];

  @override
  void initState() {
    getDepositInfo();
    super.initState();
  }

  Future<void> getDepositInfo() async {
    var data = await DepositWithDrawRepository.instance.getDepositHistory();
    setState(() {
      depositInfo = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SahaLoadingWidget()
        : ListView.builder(
            itemCount: depositInfo.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              var deposit = depositInfo[index];
              return HistoryCardTile(
                amount: deposit.depositMoney.toString(),
                from: 'Từ: ${deposit.depositTradingCode}',
                content: 'ND: ${deposit.depositContent} ',
                subContent: deposit.accountNumber,
                dateTime: deposit.depositDateTime,
              );
            },
          );
  }
}
