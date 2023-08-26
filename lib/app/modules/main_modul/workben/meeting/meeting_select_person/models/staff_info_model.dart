class StaffInfoModel {
  int? code;
  String? msg;
  StaffInfoData? data;

  StaffInfoModel({this.code, this.msg, this.data});

  StaffInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? StaffInfoData.fromJson(json['data']) : null;
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

class StaffInfoData {
  int? total;
  int? pages;
  List<StaffInfoResults>? results;

  StaffInfoData({this.total, this.pages, this.results});

  StaffInfoData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <StaffInfoResults>[];
      json['results'].forEach((v) {
        results!.add(StaffInfoResults.fromJson(v));
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

class StaffInfoResults {
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

  StaffInfoResults(
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

  StaffInfoResults.fromJson(Map<String, dynamic> json) {
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
