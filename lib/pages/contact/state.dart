import 'package:get/get.dart';

import '../../common/entities/contact.dart';

//for shared data to be accessed in other
class ContactState{
  RxList<ContactItem> contactList =<ContactItem>[].obs;
}