class RateModel {
  int? userId;
  int? bookId;
  double? bookRating;

  RateModel({this.userId, this.bookId, this.bookRating});

  RateModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bookId = json['book_id'];
    bookRating = json['book_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['book_rating'] = this.bookRating;
    return data;
  }
}