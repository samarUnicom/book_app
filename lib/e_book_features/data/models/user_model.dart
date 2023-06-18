class UserModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userImageUrl;
  String? userPassword;
  String? userConfirmPassword;
  String? userBio;

  UserModel(
      {this.userId,
      this.userName,
      this.userEmail,
      this.userImageUrl,
      this.userPassword,
      this.userConfirmPassword,
      this.userBio});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userImageUrl = json['user_imageUrl'];
    userPassword = json['user_password'];
    userConfirmPassword = json['user_confirmPassword'];
    userBio = json['user_bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_imageUrl'] = this.userImageUrl;
    data['user_password'] = this.userPassword;
    data['user_confirmPassword'] = this.userConfirmPassword;
    data['user_bio'] = this.userBio;
    return data;
  }
}
