import 'dart:convert';
import 'dart:developer';

import 'package:entry/src/data/response/donation_response.dart';
import 'package:entry/src/data/response/member_response.dart';
import 'package:entry/src/data/response/member_search_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  readJson() async {
    //For Donation Add
    // final String response = await rootBundle.loadString('assets/data.json');
    // var donationData = DonationListResponse.fromJson(json.decode(response));
    // log("Total Lenght ${donationData.data!.length}");
    // for (int i = 800; i < 831; i++) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     searchMemberXata(donationData.data![i]);
    //   });
    // }

    //For Member Add
    // final String dataResponse =
    //     await rootBundle.loadString('assets/member.json');
    // var memberData = MemberListResponse.fromJson(json.decode(dataResponse));
    // log("Total Lenght ${memberData.data!.length}");
    // for (int i = 1050; i < 1083; i++) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     uploadMemberXata(memberData.data![i]);
    //   });
    // }
  }

  //upload donationData to Xata Server with http post method
  uploadDonationXata(DonationData data, String memberId) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": 'application/json',
      "Authorization": "Bearer xau_n8jyl0ncOhjMYXFMQvgU5re57VDW9vSX2"
    };

    final response = await http.post(
      Uri.parse(
          'https://sithu-aung-s-workspace-oc5cng.us-east-1.xata.sh/db/next:main/tables/Donations/data?columns=id'),
      headers: headers,
      body: jsonEncode(
        <String, dynamic>{
          "patient_disease": data.patientDisease,
          "patient_name": data.patientName,
          "hospital": data.hospital,
          "date": data.dateDetail.toString(),
          "patient_address": data.patientAddress,
          "patient_age": data.patientAge,
          "member": memberId
        },
      ),
    );
    log(response.statusCode.toString());
    if (response.statusCode != 201) {
      log("Failed");
    }
  }

  uploadMemberXata(MemberData data) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": 'application/json',
      "Authorization": "Bearer xau_n8jyl0ncOhjMYXFMQvgU5re57VDW9vSX2"
    };

    final response = await http.post(
      Uri.parse(
          'https://sithu-aung-s-workspace-oc5cng.us-east-1.xata.sh/db/next:main/tables/Members/data?columns=id'),
      headers: headers,
      body: jsonEncode(
        <String, dynamic>{
          "birth_date": data.birthDate.toString(),
          "blood_bank_card": data.bloodBankCard.toString(),
          "last_donation_date":
              data.lastDateDetail == null ? "" : data.lastDateDetail!,
          "donation_counts": strToEng(data.memberCount.toString()),
          "note": data.note.toString(),
          "nrc": data.nrc.toString(),
          "phone": data.phone.toString(),
          "total_count": strToEng(data.totalCount.toString()),
          "father_name": data.fatherName.toString(),
          "name": data.name.toString(),
          "register_date": data.registerDate ?? "",
          "member_id": data.memberId.toString(),
          "blood_type": data.bloodType.toString(),
          "address":
              "${data.homeNo!}, ${data.street!}, ${data.quarter!}, ${data.town!}, ${data.region!}",
        },
      ),
    );
    log(response.statusCode.toString());
    if (response.statusCode != 201) {
      log("Failed");
    }
  }

  searchMemberXata(DonationData data) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": 'application/json',
      "Authorization": "Bearer xau_n8jyl0ncOhjMYXFMQvgU5re57VDW9vSX2"
    };

    final response = await http.post(
      Uri.parse(
          'https://sithu-aung-s-workspace-oc5cng.us-east-1.xata.sh/db/next:main/tables/Members/query'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "filter": {"member_id": data.memberId.toString()}
      }),
    );

    log(response.statusCode.toString());
    // log(response.body.toString());
    if (response.statusCode == 200) {
      var responseData =
          MemberSearchDataResponse.fromJson(jsonDecode(response.body));
      if (responseData.records!.isNotEmpty) {
        var memberId = responseData.records![0].id;
        uploadDonationXata(data, memberId.toString());
      } else {
        log("User Data Not Found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(),
    );
  }

  int strToEng(String converted) {
    if (converted != "") {
      converted = converted.replaceAll(RegExp('၀'), "0");
      converted = converted.replaceAll(RegExp('၁'), "1");
      converted = converted.replaceAll(RegExp('၂'), "2");
      converted = converted.replaceAll(RegExp('၃'), "3");
      converted = converted.replaceAll(RegExp('၄'), "4");
      converted = converted.replaceAll(RegExp('၅'), "5");
      converted = converted.replaceAll(RegExp('၆'), "6");
      converted = converted.replaceAll(RegExp('၇'), "7");
      converted = converted.replaceAll(RegExp('၈'), "8");
      converted = converted.replaceAll(RegExp('၉'), "9");
    } else {
      converted = "0";
    }

    return int.parse(converted);
  }
}
