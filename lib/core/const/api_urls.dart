class ApiUrls {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String posts = '$baseUrl/posts';
  static String postsById(int id) => '$baseUrl/posts/$id';
}
