import 'package:firebase_database/firebase_database.dart';

/*class userServices{
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  createUser(String uid, Map value){
    _database.reference().child(ref).push().set(
      value
    ).catchError((e)=>{print(e.toString())});
  }
}*/

class userServices{
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  createUser(Map value){

    String id = value["userId"];
    _database.reference().child("$ref/$id").set(
        value
    ).catchError((e)=>{print(e.toString())});
  }
}