class ProfileData {
  String? email;
  String? userId;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? username;

  ProfileData({
    this.email,
    this.username,
    this.userId,
    this.phone,
    this.image,
    this.cover,
    this.bio,
  });
  ProfileData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    userId = json['userId'];
    username = json['username'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'phone': phone,
      'email': email,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
