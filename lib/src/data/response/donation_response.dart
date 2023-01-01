class DonationListResponse {
  List<DonationData>? data;

  DonationListResponse({this.data});

  DonationListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DonationData>[];
      json['data'].forEach((v) {
        data!.add(DonationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DonationData {
  String? id;
  String? date;
  String? dateDetail;
  String? hospital;
  String? memberId;
  String? patientAddress;
  String? patientAge;
  String? patientDisease;
  String? patientName;

  DonationData({
    this.id,
    this.date,
    this.dateDetail,
    this.hospital,
    this.memberId,
    this.patientAddress,
    this.patientAge,
    this.patientDisease,
    this.patientName,
  });

  DonationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateDetail = json['date_detail'];
    hospital = json['hospital'];
    memberId = json['member_id'];
    patientAddress = json['patient_address'];
    patientAge = json['patient_age'];
    patientDisease = json['patient_disease'];
    patientName = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['date_detail'] = dateDetail;
    data['hospital'] = hospital;
    data['member_id'] = memberId;
    data['patient_address'] = patientAddress;
    data['patient_age'] = patientAge;
    data['patient_disease'] = patientDisease;
    data['patient_name'] = patientName;
    return data;
  }
}
