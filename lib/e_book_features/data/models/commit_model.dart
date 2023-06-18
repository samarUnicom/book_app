class CommitModel {
  String? commitId;
  String? userId;
  String? userName;
  String? commitDate;
  String? userImg;
  int? bookId;
  String? commit;

  CommitModel(
      {this.commitId,
        this.userId,
        this.userName,
        this.commitDate,
        this.userImg,
        this.bookId,
        this.commit});

  CommitModel.fromJson(Map<String, dynamic> json) {
    commitId = json['commit_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    commitDate = json['commit_date'];
    userImg = json['user_img'];
    bookId = json['book_id'];
    commit = json['commit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commit_id'] = this.commitId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['commit_date'] = this.commitDate;
    data['user_img'] = this.userImg;
    data['book_id'] = this.bookId;
    data['commit'] = this.commit;
    return data;
  }
}
