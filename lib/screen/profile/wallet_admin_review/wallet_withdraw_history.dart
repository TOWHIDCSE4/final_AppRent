import 'package:flutter/material.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';

class WalletWithdrawHistory extends StatelessWidget {
  const WalletWithdrawHistory({super.key});

  final _histories = const <Map<String, dynamic>>[
    {
      'amount': '3.500.000',
      'bankName': 'TCB',
      'to': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30 05/07/2023',
      'isDeposit': false,
      'completed': false,
    },
    {
      'amount': '5.000.000',
      'bankName': 'AgriBank',
      'to': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
      'isDeposit': false,
      'completed': true,
    },
    {
      'amount': '10.000.000',
      'bankName': 'VCB',
      'to': '0866816177',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
      'isDeposit': false,
      'completed': true,
    },
    {
      'amount': '3.500.000',
      'bankName': 'MB',
      'to': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
      'isDeposit': false,
      'completed': true,
    },
    {
      'amount': '5.000.000',
      'bankName': 'VCB',
      'to': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
      'isDeposit': false,
      'completed': true,
    },
    {
      'amount': '10.000.000',
      'bankName': 'MB',
      'to': '0866816177',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
      'isDeposit': false,
      'completed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.separated(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            itemCount: _histories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return WalletHistoryCard(
                amountStr: _histories[index]['amount'],
                bankName: _histories[index]['bankName'],
                fromOrTo: _histories[index]['to'],
                content: _histories[index]['content'],
                dateTimeStr: _histories[index]['dateTimeStr'],
                isDeposit: _histories[index]['isDeposit'],
                completed: _histories[index]['completed'],
              );
            },
          ),
        ),
        const Paginator(),
      ],
    );
  }
}
