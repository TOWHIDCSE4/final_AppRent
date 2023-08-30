import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gohomy/data/remote/inteceptors/auth_interceptor.dart';
import 'package:gohomy/data/remote/saha_service_manager.dart';
import 'package:gohomy/data/repository/handle_error.dart';
import 'package:gohomy/screen/profile/deposit_withdraw/domain/withdraw_history_model.dart';

import '../domain/deposit_history_model.dart';

class DepositWithDrawRepository {
  DepositWithDrawRepository._();
  static DepositWithDrawRepository instance = DepositWithDrawRepository._();

  Future<List<Deposit>> getDepositHistory() async {
    List<Deposit> depositList = [];
    try {
      DepositHistoryModel info = await SahaServiceManager().service!.getDepositHistoryData();
      depositList = info.data;
      return info.data;
    } catch (err) {
      handleError(err);
    }
    return depositList;
  }

  Future<List<Withdraw>> getWithdrawHistory() async {
    List<Withdraw> withdrawList = [];
    try {
      WithdrawHistoryModel info = await SahaServiceManager().service!.getWithdrawHistoryData();
      withdrawList = info.data;
      return info.data;
    } catch (err) {
      handleError(err);
    }
    return withdrawList;
  }
}