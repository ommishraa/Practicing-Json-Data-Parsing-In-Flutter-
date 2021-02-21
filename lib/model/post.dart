class PostList {
  final List<Post> posts;

  PostList({this.posts});
  factory PostList.fromJson(List<dynamic> parsedjson) {
    List<Post> post = new List<Post>();
    post = parsedjson.map((i) => Post.fromJson(i)).toList();

    return new PostList(posts: post);
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
