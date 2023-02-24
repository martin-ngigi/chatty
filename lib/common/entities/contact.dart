/**
    {"access_token":"38119fb15b94a1eb3297c3eb4f359868","token":"93bc9744c24e5101f02efc6e2b23083c","name":"Martin Wainaina","description":null,"avatar":"https://lh3.googleusercontent.com/a/AGNmyxbpWYX1cLIHERdsPNGDHJKI_HLy_rdghlf8eZ9oqQ=s96-c","online":null,"type":2}
 */

class ContactItem {
  String? token; //other person's token... not you
  String? name;
  String? description;
  String? avatar;
  int? online;

  ContactItem(
      {
        this.token,
        this.name,
        this.description,
        this.avatar,
        this.online,
      });

  ContactItem.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['online'] = this.online;
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
