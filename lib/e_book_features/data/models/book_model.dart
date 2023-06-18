

class BookModel {
  int? bookId;
  String? bookName;
  String? bookAuthor;
  String? bookAuthorImg;
  String? bookImageUrl;
  String? bookLink;
  String? bookCommit;
  String? bookBio;
  double? bookRating;
  String? bookPublishDate;

  BookModel(
      {this.bookId,
        this.bookName,
        this.bookAuthor,
        this.bookAuthorImg,
        this.bookImageUrl,
        this.bookLink,
        this.bookCommit,
        this.bookBio,
        this.bookRating,
        this.bookPublishDate});

  BookModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    bookAuthor = json['book_author'];
    bookAuthorImg = json['book_author_img'];
    bookImageUrl = json['book_imageUrl'];
    bookLink = json['book_link'];
    bookCommit = json['book_commit'];
    bookBio = json['book_bio'];
    bookRating = json['book_rating'];
    bookPublishDate = json['book_publishDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['book_author'] = this.bookAuthor;
    data['book_author_img'] = this.bookAuthorImg;
    data['book_imageUrl'] = this.bookImageUrl;
    data['book_link'] = this.bookLink;
    data['book_commit'] = this.bookCommit;
    data['book_bio'] = this.bookBio;
    data['book_rating'] = this.bookRating;
    data['book_publishDate'] = this.bookPublishDate;
    return data;
  }
}