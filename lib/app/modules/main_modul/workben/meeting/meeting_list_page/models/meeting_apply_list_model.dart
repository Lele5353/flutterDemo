class MeetingApplyListModel {
  int? code;
  String? msg;
  MeetingApplyData? data;

  MeetingApplyListModel({this.code, this.msg, this.data});

  MeetingApplyListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data =
        json['data'] != null ? MeetingApplyData.fromJson(json['data']) : null;
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

class MeetingApplyData {
  int? total;
  int? pages;
  List<MeetingApplyResults>? results;

  MeetingApplyData({this.total, this.pages, this.results});

  MeetingApplyData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <MeetingApplyResults>[];
      json['results'].forEach((v) {
        results!.add(MeetingApplyResults.fromJson(v));
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

class MeetingApplyResults {
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
  Applicant? applicant;
  MeetingType? meetingType;
  MeetingRoom? meetingRoom;
  Notetaker? notetaker;
  List<Conferee>? conferee;
  List<DjangoFile>? djangoFile;
  List<MeetingarrangementSet>? meetingarrangementSet;

  MeetingApplyResults(
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
      this.djangoFile,
      this.meetingarrangementSet});

  MeetingApplyResults.fromJson(Map<String, dynamic> json) {
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
    applicant = json['applicant'] != null
        ? Applicant.fromJson(json['applicant'])
        : null;
    meetingType = json['meeting_type'] != null
        ? MeetingType.fromJson(json['meeting_type'])
        : null;
    meetingRoom = json['meeting_room'] != null
        ? MeetingRoom.fromJson(json['meeting_room'])
        : null;
    notetaker = json['notetaker'] != null
        ? Notetaker.fromJson(json['notetaker'])
        : null;
    if (json['conferee'] != null) {
      conferee = <Conferee>[];
      json['conferee'].forEach((v) {
        conferee!.add(Conferee.fromJson(v));
      });
    }
    if (json['django_file'] != null) {
      djangoFile = <DjangoFile>[];
      json['django_file'].forEach((v) {
        djangoFile!.add(DjangoFile.fromJson(v));
      });
    }
    if (json['meetingarrangement_set'] != null) {
      meetingarrangementSet = <MeetingarrangementSet>[];
      json['meetingarrangement_set'].forEach((v) {
        meetingarrangementSet!.add(MeetingarrangementSet.fromJson(v));
      });
    }
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
    if (applicant != null) {
      data['applicant'] = applicant!.toJson();
    }
    if (meetingType != null) {
      data['meeting_type'] = meetingType!.toJson();
    }
    if (meetingRoom != null) {
      data['meeting_room'] = meetingRoom!.toJson();
    }
    if (notetaker != null) {
      data['notetaker'] = notetaker!.toJson();
    }
    if (conferee != null) {
      data['conferee'] = conferee!.map((v) => v.toJson()).toList();
    }
    if (djangoFile != null) {
      data['django_file'] = djangoFile!.map((v) => v.toJson()).toList();
    }
    if (meetingarrangementSet != null) {
      data['meetingarrangement_set'] =
          meetingarrangementSet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Applicant {
  int? id;
  String? choicesKey;
  String? lastLogin;
  String? username;
  bool? isActive;
  String? dateJoined;
  List<int>? groups;

  Applicant(
      {this.id,
      this.choicesKey,
      this.lastLogin,
      this.username,
      this.isActive,
      this.dateJoined,
      this.groups});

  Applicant.fromJson(Map<String, dynamic> json) {
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

class Conferee {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? dataNumber;
  String? name;
  int? gender;
  String? phone;
  String? speciality;
  String? hobby;
  int? nation;
  String? nativePlace;
  String? birthDate;
  String? idCard;
  int? politicFace;
  String? email;
  String? regionCode;
  String? residentialAddress;
  int? education;
  int? degree;
  int? marital;
  int? health;
  int? height;
  int? weight;
  String? foreignLanguageLevel;
  String? entryDate;
  String? regularDate;
  int? state;
  String? salaryWelfare;
  List<int>? postInfo;
  List<int>? workHistory;
  List<int>? emergencyContact;
  List<int>? educationalExperience;
  List<int>? familyMembers;

  Conferee(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.dataNumber,
      this.name,
      this.gender,
      this.phone,
      this.speciality,
      this.hobby,
      this.nation,
      this.nativePlace,
      this.birthDate,
      this.idCard,
      this.politicFace,
      this.email,
      this.regionCode,
      this.residentialAddress,
      this.education,
      this.degree,
      this.marital,
      this.health,
      this.height,
      this.weight,
      this.foreignLanguageLevel,
      this.entryDate,
      this.regularDate,
      this.state,
      this.salaryWelfare,
      this.postInfo,
      this.workHistory,
      this.emergencyContact,
      this.educationalExperience,
      this.familyMembers});

  Conferee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    dataNumber = json['data_number'];
    name = json['name'];
    gender = json['gender'];
    phone = json['phone'];
    speciality = json['speciality'];
    hobby = json['hobby'];
    nation = json['nation'];
    nativePlace = json['native_place'];
    birthDate = json['birth_date'];
    idCard = json['id_card'];
    politicFace = json['politic_face'];
    email = json['email'];
    regionCode = json['region_code'];
    residentialAddress = json['residential_address'];
    education = json['education'];
    degree = json['degree'];
    marital = json['marital'];
    health = json['health'];
    height = json['height'];
    weight = json['weight'];
    foreignLanguageLevel = json['foreign_language_level'];
    entryDate = json['entry_date'];
    regularDate = json['regular_date'];
    state = json['state'];
    salaryWelfare = json['salary_welfare'];
    postInfo = json['post_info'].cast<int>();
    workHistory = json['work_history'].cast<int>();
    emergencyContact = json['emergency_contact'].cast<int>();
    educationalExperience = json['educational_experience'].cast<int>();
    familyMembers = json['family_members'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['data_number'] = dataNumber;
    data['name'] = name;
    data['gender'] = gender;
    data['phone'] = phone;
    data['speciality'] = speciality;
    data['hobby'] = hobby;
    data['nation'] = nation;
    data['native_place'] = nativePlace;
    data['birth_date'] = birthDate;
    data['id_card'] = idCard;
    data['politic_face'] = politicFace;
    data['email'] = email;
    data['region_code'] = regionCode;
    data['residential_address'] = residentialAddress;
    data['education'] = education;
    data['degree'] = degree;
    data['marital'] = marital;
    data['health'] = health;
    data['height'] = height;
    data['weight'] = weight;
    data['foreign_language_level'] = foreignLanguageLevel;
    data['entry_date'] = entryDate;
    data['regular_date'] = regularDate;
    data['state'] = state;
    data['salary_welfare'] = salaryWelfare;
    data['post_info'] = postInfo;
    data['work_history'] = workHistory;
    data['emergency_contact'] = emergencyContact;
    data['educational_experience'] = educationalExperience;
    data['family_members'] = familyMembers;
    return data;
  }
}

class MeetingType {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? name;

  MeetingType(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.name});

  MeetingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['name'] = name;
    return data;
  }
}

class MeetingRoom {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? name;
  int? roomType;
  String? place;
  int? maxTurnout;
  int? state;
  List? equipment;

  MeetingRoom(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.name,
      this.roomType,
      this.place,
      this.maxTurnout,
      this.state,
      this.equipment});

  MeetingRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    name = json['name'];
    roomType = json['room_type'];
    place = json['place'];
    maxTurnout = json['max_turnout'];
    state = json['state'];
    if (json['equipment'] != null) {
      equipment = [];
      json['equipment'].forEach((v) {
        if (v is int) {
          equipment!.add(v);
        } else {
          equipment!.add(v.fromJson(v));
        }
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
    data['name'] = name;
    data['room_type'] = roomType;
    data['place'] = place;
    data['max_turnout'] = maxTurnout;
    data['state'] = state;
    if (equipment != null) {
      data['equipment'] = equipment!.map((v) {
        if (v is int) {
          return v;
        } else {
          return v.toJson();
        }
      }).toList();
    }
    return data;
  }
}

class Notetaker {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? dataNumber;
  String? name;
  int? gender;
  String? phone;
  String? speciality;
  String? hobby;
  int? nation;
  String? nativePlace;
  String? birthDate;
  String? idCard;
  int? politicFace;
  String? email;
  String? regionCode;
  String? residentialAddress;
  int? education;
  int? degree;
  int? marital;
  int? health;
  int? height;
  int? weight;
  String? foreignLanguageLevel;
  String? entryDate;
  String? regularDate;
  int? state;
  String? salaryWelfare;
  List<int>? postInfo;
  List<int>? workHistory;
  List<int>? emergencyContact;
  List<int>? educationalExperience;
  List<int>? familyMembers;

  Notetaker(
      {this.id,
      this.choicesKey,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.dataNumber,
      this.name,
      this.gender,
      this.phone,
      this.speciality,
      this.hobby,
      this.nation,
      this.nativePlace,
      this.birthDate,
      this.idCard,
      this.politicFace,
      this.email,
      this.regionCode,
      this.residentialAddress,
      this.education,
      this.degree,
      this.marital,
      this.health,
      this.height,
      this.weight,
      this.foreignLanguageLevel,
      this.entryDate,
      this.regularDate,
      this.state,
      this.salaryWelfare,
      this.postInfo,
      this.workHistory,
      this.emergencyContact,
      this.educationalExperience,
      this.familyMembers});

  Notetaker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    dataNumber = json['data_number'];
    name = json['name'];
    gender = json['gender'];
    phone = json['phone'];
    speciality = json['speciality'];
    hobby = json['hobby'];
    nation = json['nation'];
    nativePlace = json['native_place'];
    birthDate = json['birth_date'];
    idCard = json['id_card'];
    politicFace = json['politic_face'];
    email = json['email'];
    regionCode = json['region_code'];
    residentialAddress = json['residential_address'];
    education = json['education'];
    degree = json['degree'];
    marital = json['marital'];
    health = json['health'];
    height = json['height'];
    weight = json['weight'];
    foreignLanguageLevel = json['foreign_language_level'];
    entryDate = json['entry_date'];
    regularDate = json['regular_date'];
    state = json['state'];
    salaryWelfare = json['salary_welfare'];
    postInfo = json['post_info'].cast<int>();
    workHistory = json['work_history'].cast<int>();
    emergencyContact = json['emergency_contact'].cast<int>();
    educationalExperience = json['educational_experience'].cast<int>();
    familyMembers = json['family_members'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['data_number'] = dataNumber;
    data['name'] = name;
    data['gender'] = gender;
    data['phone'] = phone;
    data['speciality'] = speciality;
    data['hobby'] = hobby;
    data['nation'] = nation;
    data['native_place'] = nativePlace;
    data['birth_date'] = birthDate;
    data['id_card'] = idCard;
    data['politic_face'] = politicFace;
    data['email'] = email;
    data['region_code'] = regionCode;
    data['residential_address'] = residentialAddress;
    data['education'] = education;
    data['degree'] = degree;
    data['marital'] = marital;
    data['health'] = health;
    data['height'] = height;
    data['weight'] = weight;
    data['foreign_language_level'] = foreignLanguageLevel;
    data['entry_date'] = entryDate;
    data['regular_date'] = regularDate;
    data['state'] = state;
    data['salary_welfare'] = salaryWelfare;
    data['post_info'] = postInfo;
    data['work_history'] = workHistory;
    data['emergency_contact'] = emergencyContact;
    data['educational_experience'] = educationalExperience;
    data['family_members'] = familyMembers;
    return data;
  }
}

class DjangoFile {
  int? id;
  String? choicesKey;
  String? size;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? name;
  String? contentType;
  String? file;
  int? uploadUser;
  int? model;

  DjangoFile(
      {this.id,
      this.choicesKey,
      this.size,
      this.createTime,
      this.updateTime,
      this.forbidState,
      this.name,
      this.contentType,
      this.file,
      this.uploadUser,
      this.model});

  DjangoFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    size = json['size'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    name = json['name'];
    contentType = json['content_type'];
    file = json['file'];
    uploadUser = json['upload_user'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['choices_key'] = choicesKey;
    data['size'] = size;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['forbid_state'] = forbidState;
    data['name'] = name;
    data['content_type'] = contentType;
    data['file'] = file;
    data['upload_user'] = uploadUser;
    data['model'] = model;
    return data;
  }
}

class MeetingarrangementSet {
  int? id;
  String? choicesKey;
  String? createTime;
  String? updateTime;
  bool? forbidState;
  String? task;
  String? finishTime;
  int? taskState;
  int? meetingRoomApply;
  int? principal;
  int? acceptor;
  List? djangoFile;

  MeetingarrangementSet(
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

  MeetingarrangementSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choicesKey = json['choices_key'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    forbidState = json['forbid_state'];
    task = json['task'];
    finishTime = json['finish_time'];
    taskState = json['task_state'];
    meetingRoomApply = json['meeting_room_apply'];
    principal = json['principal'];
    acceptor = json['acceptor'];
    if (json['django_file'] != null) {
      djangoFile = [];
      json['django_file'].forEach((v) {
        if (v is int) {
          json['django_file'].cast<int>();
        } else {
          djangoFile!.add(v.fromJson(v));
        }
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
    data['meeting_room_apply'] = meetingRoomApply;
    data['principal'] = principal;
    data['acceptor'] = acceptor;
    if (djangoFile != null) {
      data['django_file'] = djangoFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
