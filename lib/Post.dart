class Post {
  final String fname;
  final String sname;
  final String percentage;
  final String result;

  Post({this.fname, this.sname, this.percentage, this.result});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      fname: json['fname'],
      sname: json['sname'],
      percentage: json['percentage'],
      result: json['result'],
    );
  }
}
