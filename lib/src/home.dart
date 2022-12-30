import 'dart:convert';
import 'dart:developer';

import 'package:entry/src/data/response/member_response.dart';
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
  }

  readJson() async {
    final String response =
        await rootBundle.loadString('assets/master_data.json');
    var memberData = MemberListResponse.fromJson(json.decode(response));
    // for (var element in memberData.data!) {
    //   Future.delayed(const Duration(seconds: 1)).then((value) {
    //     uploadXata(element);
    //   });
    // }
    for (int i = 0; i < 3; i++) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        uploadXata(memberData.data![i]);
      });
    }
  }

  //upload memberData to Xata Server with http post method
  uploadXata(MemberData data) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": 'application/json',
      "Authorization": "Bearer xau_n8jyl0ncOhjMYXFMQvgU5re57VDW9vSX2"
    };

    final response = await http.post(
        Uri.parse(
            'https://sithu-aung-s-workspace-oc5cng.us-east-1.xata.sh/db/next:main/tables/Members/data?columns=id'),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          "birth_date": data.birthDate,
          "blood_bank_card": data.bloodBankCard,
          "last_donation_date": DateTime.parse(data.lastDateDetail!),
          "donation_counts": data.memberCount,
          "note": data.note,
          "nrc": data.nrc,
          "phone": data.phone,
          "total_count": data.totalCount,
          "father_name": data.fatherName,
          "name": data.name,
          "register_date": DateTime.parse(data.registerDate!),
          "member_id": data.memberId,
          "blood_type": data.bloodType,
          "address":
              "${data.homeNo!}, ${data.street!}, ${data.quarter!}, ${data.town!}, ${data.region!}",
        }));
    log(response.statusCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
