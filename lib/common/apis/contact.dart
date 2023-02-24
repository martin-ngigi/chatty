import 'package:chatty/common/entities/entities.dart';

import '../entities/contact.dart';
import '../utils/http.dart';

class ContactAPI{
  static Future<ContactResponseEntity> post_contact() async {
       var response = await HttpUtil().post(
         'api/contact',
       );
      return ContactResponseEntity.fromJson(response);
    }


}