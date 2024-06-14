
class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.about,
    this.createdAt,
    this.lastOnlineStatus,
    this.status,
    this.role
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["profileImage"] is String) {
      profileImage = json["profileImage"];
    }
    if(json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if(json["About"] is String) {
      about = json["About"];
    }
    if(json["CreatedAt"] is String) {
      createdAt = json["CreatedAt"];
    }
    if(json["LastOnlineStatus"] is String) {
      lastOnlineStatus = json["LastOnlineStatus"];
    }
    if(json["Status"] is String) {
      status = json["Status"];
    }
    if(json["Role"] is String) {
      role = json["Role"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["profileImage"] = profileImage;
    _data["phoneNumber"] = phoneNumber;
    _data["About"] = about;
    _data["CreatedAt"] = createdAt;
    _data["LastOnlineStatus"] = lastOnlineStatus;
    _data["Status"] = status;
    _data["Role"] = role;
    return _data;
  }
}