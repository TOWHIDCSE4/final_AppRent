import 'package:flutter/material.dart';
import 'package:gohomy/const/color.dart';

import 'deposit_history_tile.dart';
import 'withdraw_history_tile.dart';

class TabbarTile extends StatelessWidget {
  const TabbarTile({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lịch sử dòng tiền',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                initialIndex: initialIndex,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(30),
                    child: SafeArea(
                      child: Column(
                        children: const [
                          TabBar(
                            tabs: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Nạp",
                                  style: TextStyle(
                                    color: AppColor.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Rút",
                                  style: TextStyle(
                                    color: Color(0xFFF83232),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: const TabBarView(
                    children: <Widget>[
                      DepositHistoryTile(),
                      WithdrawHistoryTile()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
