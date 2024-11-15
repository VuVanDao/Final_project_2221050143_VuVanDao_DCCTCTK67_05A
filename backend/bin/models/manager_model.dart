// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//dai dien cho bhiem vu, cong viec
class ManageModel {
  int msv;
  String ten;
  String lop;
  double gpa;
  bool diemdanh;
  ManageModel({
    required this.msv,
    required this.ten,
    required this.lop,
    required this.gpa,
    required this.diemdanh,
  });

  ManageModel copyWith({
    int? msv,
    String? ten,
    String? lop,
    double? gpa,
    bool? diemdanh,
  }) {
    return ManageModel(
      msv: msv ?? this.msv,
      ten: ten ?? this.ten,
      lop: lop ?? this.lop,
      gpa: gpa ?? this.gpa,
      diemdanh: diemdanh ?? this.diemdanh,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msv': msv,
      'ten': ten,
      'lop': lop,
      'gpa': gpa,
      'diemdanh': diemdanh,
    };
  }

  factory ManageModel.fromMap(Map<String, dynamic> map) {
    return ManageModel(
      msv: map['msv'] as int,
      ten: map['ten'] as String,
      lop: map['lop'] as String,
      gpa: map['gpa'] as double,
      diemdanh: map['diemdanh'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageModel.fromJson(String source) =>
      ManageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ManageModel(msv: $msv, ten: $ten, lop: $lop, gpa: $gpa, diemdanh: $diemdanh)';
  }

  @override
  bool operator ==(covariant ManageModel other) {
    if (identical(this, other)) return true;

    return other.msv == msv &&
        other.ten == ten &&
        other.lop == lop &&
        other.gpa == gpa &&
        other.diemdanh == diemdanh;
  }

  @override
  int get hashCode {
    return msv.hashCode ^
        ten.hashCode ^
        lop.hashCode ^
        gpa.hashCode ^
        diemdanh.hashCode;
  }
}
