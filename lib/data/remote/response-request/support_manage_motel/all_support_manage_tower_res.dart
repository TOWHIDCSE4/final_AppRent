

import '../../../../model/support_manage_tower.dart';


class AllSupportManageTowerRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Data? data;

    AllSupportManageTowerRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllSupportManageTowerRes.fromJson(Map<String, dynamic> json) => AllSupportManageTowerRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    int? currentPage;
    List<SupportManageTower>? data;
   
    String? nextPageUrl;


    Data({
        this.currentPage,
        this.data,
       
        this.nextPageUrl,
     
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<SupportManageTower>.from(json["data"]!.map((x) => SupportManageTower.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
   
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
       
        "next_page_url": nextPageUrl,
    
    };
}



