/**
    {"access_token":"38119fb15b94a1eb3297c3eb4f359868","token":"93bc9744c24e5101f02efc6e2b23083c","name":"Martin Wainaina","description":null,"avatar":"https://lh3.googleusercontent.com/a/AGNmyxbpWYX1cLIHERdsPNGDHJKI_HLy_rdghlf8eZ9oqQ=s96-c","online":null,"type":2}
 */

class ContactItem {
  String? accessToken;
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? online;
  int? type;

  ContactItem(
      {this.accessToken,
        this.token,
        this.name,
        this.description,
        this.avatar,
        this.online,
        this.type});

  ContactItem.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    token = json['token'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    online = json['online'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token'] = this.token;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['online'] = this.online;
    data['type'] = this.type;
    return data;
  }
}

class ContactResponseEntity {
  int? code;
  String? msg;
  List<ContactItem>? data;

  ContactResponseEntity({
    this.code,
    this.data,
    this.msg
  });

  factory ContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      ContactResponseEntity(
          code : json['code'],
          data : json['data'] == null
          ? []
              : List<ContactItem>.from(json["data"].map((x) => ContactItem.fromJson(x))),
          msg : json['msg'],
      );


  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data == null
      ? []
      : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

}
