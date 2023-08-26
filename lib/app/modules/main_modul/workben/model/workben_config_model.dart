class WorkbenConfigModel {
  int? code;
  String? msg;
  DataList? data;

  WorkbenConfigModel({this.code, this.msg, this.data});

  WorkbenConfigModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? DataList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataList {
  int? total;
  int? pages;
  List<ResultsData>? results;

  DataList({this.total, this.pages, this.results});

  DataList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <ResultsData>[];
      json['results'].forEach((v) {
        results!.add(ResultsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['pages'] = pages;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsData {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  // Fields? fields;
  String? url;
  int? model;

  ResultsData(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.url,
      this.model});

  ResultsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    // fields = json['fields'] != null ?  Fields.fromJson(json['fields']) : null;
    url = json['url'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    // if (fields != null) {
    //   data['fields'] = fields!.toJson();
    // }
    data['url'] = url;
    data['model'] = model;
    return data;
  }
}
