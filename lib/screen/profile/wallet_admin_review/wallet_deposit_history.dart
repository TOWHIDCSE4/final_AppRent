import 'package:flutter/material.dart';
import 'package:gohomy/screen/profile/wallet_admin_review/wallet_admin_review.dart';

class WalletDepositHistory extends StatelessWidget {
  const WalletDepositHistory({super.key});

  final _histories = const <Map<String, dynamic>>[
    {
      'amount': '3.500.000',
      'from': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30 05/07/2023',
    },
    {
      'amount': '5.000.000',
      'from': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
    },
    {
      'amount': '10.000.000',
      'from': '0866816177',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
    },
    {
      'amount': '3.500.000',
      'from': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
    },
    {
      'amount': '5.000.000',
      'from': '0986036652',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
    },
    {
      'amount': '10.000.000',
      'from': '0866816177',
      'content': 'Nạp tiền tài khoản',
      'dateTimeStr': '8:30   05/07/2023',
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
                fromOrTo: _histories[index]['from'],
                content: _histories[index]['content'],
                dateTimeStr: _histories[index]['dateTimeStr'],
              );
            },
          ),
        ),
        const Paginator(),
      ],
    );
  }
}
