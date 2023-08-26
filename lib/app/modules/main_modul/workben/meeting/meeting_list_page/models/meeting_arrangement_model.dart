class MeetingArrangementModel {
  int? code;
  String? msg;
  Data? data;

  MeetingArrangementModel({this.code, this.msg, this.data});

  MeetingArrangementModel.fromJson(Map<String, dynamic> json) {
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
  List<ArrangementResults>? results;

  Data({this.total, this.pages, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <ArrangementResults>[];
      json['results'].forEach((v) {
        results!.add(ArrangementResults.fromJson(v));
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

class ArrangementResults {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? task;
  String? finishTime;
  int? taskState;
  MeetingRoomApply? meetingRoomApply;
  Principal? principal;
  Acceptor? acceptor;
  List? djangoFile;

  ArrangementResults(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.task,
      this.finishTime,
      this.taskState,
      this.meetingRoomApply,
      this.principal,
      this.acceptor,
      this.djangoFile});

  ArrangementResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    task = json['task'];
    finishTime = json['finish_time'];
    taskState = json['task_state'];
    meetingRoomApply = json['meeting_room_apply'] != null
        ? MeetingRoomApply.fromJson(json['meeting_room_apply'])
        : null;
    principal = json['principal'] != null
        ? Principal.fromJson(json['principal'])
        : null;
    acceptor =
        json['acceptor'] != null ? Acceptor.fromJson(json['acceptor']) : null;
    if (json['django_file'] != null) {
      djangoFile = [];
      json['django_file'].forEach((v) {
        djangoFile!.add(v.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['task'] = task;
    data['finish_time'] = finishTime;
    data['task_state'] = taskState;
    if (meetingRoomApply != null) {
      data['meeting_room_apply'] = meetingRoomApply!.toJson();
    }
    if (principal != null) {
      data['principal'] = principal!.toJson();
    }
    if (acceptor != null) {
      data['acceptor'] = acceptor!.toJson();
    }
    if (djangoFile != null) {
      data['django_file'] = djangoFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeetingRoomApply {
  int? id;
  String? choicesKey;
  String? meetingStatus;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? applyNumber;
  String? theme;
  String? startDate;
  String? endDate;
  String? compere;
  String? spareParts;
  String? meetingRequirements;
  int? applicant;
  int? meetingType;
  int? meetingRoom;
  int? notetaker;
  List<int>? conferee;
  List<int>? djangoFile;

  MeetingRoomApply(
      {this.id,
      this.choicesKey,
      this.meetingStatus,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.applyNumber,
      this.theme,
      this.startDate,
      this.endDate,
      this.compere,
      this.spareParts,
      this.meetingRequirements,
      this.applicant,
      this.meetingType,
      this.meetingRoom,
      this.notetaker,
      this.conferee,
      this.djangoFile});

  MeetingRoomApply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    meetingStatus = json['meeting_status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    applyNumber = json['apply_number'];
    theme = json['theme'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    compere = json['compere'];
    spareParts = json['spare_parts'];
    meetingRequirements = json['meeting_requirements'];
    applicant = json['applicant'];
    meetingType = json['meeting_type'];
    meetingRoom = json['meeting_room'];
    notetaker = json['notetaker'];
    conferee = json['conferee'].cast<int>();
    djangoFile = json['django_file'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['meeting_status'] = meetingStatus;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['apply_number'] = applyNumber;
    data['theme'] = theme;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['compere'] = compere;
    data['spare_parts'] = spareParts;
    data['meeting_requirements'] = meetingRequirements;
    data['applicant'] = applicant;
    data['meeting_type'] = meetingType;
    data['meeting_room'] = meetingRoom;
    data['notetaker'] = notetaker;
    data['conferee'] = conferee;
    data['django_file'] = djangoFile;
    return data;
  }
}

class Principal {
  int? id;
  String? choicesKey;
  String? lastLogin;
  String? username;
  bool? isActive;
  String? dateJoined;
  List<int>? groups;

  Principal({
    this.id,
    this.choicesKey,
    this.lastLogin,
    this.username,
    this.isActive,
    this.dateJoined,
    this.groups,
  });

  Principal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    lastLogin = json['last_login'];
    username = json['username'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    groups = json['groups'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['last_login'] = lastLogin;
    data['username'] = username;
    data['is_active'] = isActive;
    data['date_joined'] = dateJoined;
    data['groups'] = groups;

    return data;
  }
}

class Acceptor {
  int? id;
  String? choicesKey;
  String? lastLogin;
  String? username;
  bool? isActive;
  String? dateJoined;
  List<int>? groups;

  Acceptor(
      {this.id,
      this.choicesKey,
      this.lastLogin,
      this.username,
      this.isActive,
      this.dateJoined,
      this.groups});

  Acceptor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    lastLogin = json['last_login'];
    username = json['username'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    groups = json['groups'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['last_login'] = lastLogin;
    data['username'] = username;
    data['is_active'] = isActive;
    data['date_joined'] = dateJoined;
    data['groups'] = groups;
    return data;
  }
}
