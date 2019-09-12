/// function: bean
/// <p>Created by Leo on 2019/5/10.</p>

class TestModel {
  String msg;

  TestModel({this.msg});

  TestModel.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}
