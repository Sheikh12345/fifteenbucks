class Student {
  int? _rollNo;
  String? _name;

  Student.fromJson(dynamic json) {
    _rollNo = json['roll_no'];
    _name = json['name'];
  }

  int? get rollNo => _rollNo;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['roll_no'] = _rollNo;
    return map;
  }
}
