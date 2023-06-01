class ChatUser {
  ChatUser({
    required this.image,
    required this.isOnline,
    required this.pushToken,
    required this.lastActive,
    required this.createdAt,
    required this.about,
    required this.name,
    required this.id,
  });
  late final String image;
  late final bool isOnline;
  late final String pushToken;
  late final String lastActive;
  late final String createdAt;
  late final String about;
  late final String name;
  late final String id;
  
  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
    lastActive = json['last_active'];
    createdAt = json['created_at'];
    about = json['about'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    data['last_active'] = lastActive;
    data['created_at'] = createdAt;
    data['about'] = about;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}