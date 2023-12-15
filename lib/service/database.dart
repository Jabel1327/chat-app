
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserbyemail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future<QuerySnapshot> Search(String username) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("searchKey", isEqualTo: username.substring(0, 1).toUpperCase())
        .get();
  }
}
