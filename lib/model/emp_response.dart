import 'employe_model.dart';

class EmpResponse {
  String? status;
  List<Employee>? data;
  String? message;

  EmpResponse(this.status, this.data, this.message);

  EmpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = List<Employee>.from(json['data'].map((x) => Employee.fromJson(x)));
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
        'message': message,
      };
}
