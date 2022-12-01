class UserField {

  static const String username = 'username';
  static const String number = 'number';
  static const String id = 'id';
  static const String profileImage = 'profileImage';
  static const String coverImage = 'coverImage';
  static const String interests = 'interests';
  static const String verified = 'verified';

}

class UserModel {
  final String username, number;
  final String? id, profileImage, coverImage;
  final List<dynamic> interests;
  final bool verified;

  UserModel({
    this.id,
    required this.number,
    required this.username,
    required this.interests,
    this.verified = false,
    this.profileImage,
    this.coverImage,
  });

  UserModel update({
    String? id,
    String? number,
    String? username,
    bool? verified,
    String? profileImage,
    String? coverImage,
    List<String>? interests,
  }) {
    return UserModel(
      id: id ?? this.id,
      number: number ?? this.number,
      username: username ?? this.username,
      verified: verified ?? this.verified,
      interests: interests ?? this.interests,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json[UserField.id],
      number: json[UserField.number],
      username: json[UserField.username],
      verified: json[UserField.verified],
      interests: json[UserField.interests],
      profileImage: json[UserField.profileImage],
      coverImage: json[UserField.coverImage],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserField.id: id,
      UserField.number: number,
      UserField.username: username,
      UserField.verified: verified,
      UserField.interests: interests,
      UserField.profileImage: profileImage,
      UserField.coverImage: coverImage,
    };
  }
}
