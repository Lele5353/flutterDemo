class NoticeModel {
  int? code;
  String? msg;
  Data? data;

  NoticeModel({this.code, this.msg, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? total;
  int? pages;
  List<Results>? results;

  Data({this.total, this.pages, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
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

class Results {
  int? id;
  String? choicesKey;
  bool? isRead;
  bool? isTopping;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? title;
  String? issuedOrg;
  int? type;
  PublishObject? publishObject;
  int? status;
  int? publisher;
  List<int>? readUsers;
  List<int>? djangoFile;

  Results(
      {this.id,
      this.choicesKey,
      this.isRead,
      this.isTopping,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.title,
      this.issuedOrg,
      this.type,
      this.publishObject,
      this.status,
      this.publisher,
      this.readUsers,
      this.djangoFile});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    isRead = json['is_read'];
    isTopping = json['is_topping'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    title = json['title'];
    issuedOrg = json['issued_org'];
    type = json['type'];
    publishObject = json['publish_object'] != null
        ? PublishObject.fromJson(json['publish_object'])
        : null;
    status = json['status'];
    publisher = json['publisher'];
    readUsers = json['read_users'].cast<int>();
    djangoFile = json['django_file'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['is_read'] = isRead;
    data['is_topping'] = isTopping;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['title'] = title;
    data['issued_rg'] = issuedOrg;
    data['type'] = type;
    if (publishObject != null) {
      data['publish_object'] = publishObject!.toJson();
    }
    data['status'] = status;
    data['publisher'] = publisher;
    data['read_users'] = readUsers;
    data['django_file'] = djangoFile;
    return data;
  }
}

class PublishObject {
  List<int>? orgList;
  List<int>? userList;

  PublishObject({this.orgList, this.userList});

  PublishObject.fromJson(Map<String, dynamic> json) {
    orgList = json['org_list'] == null ? [] : json['org_list'].cast<int>();
    userList = json['user_list'] == null ? [] : json['user_list'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['org_list'] = orgList;
    data['user_list'] = userList;
    return data;
  }
}
