import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseActionsUser{
  static void favoritar(String idObra, bool status) async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      DatabaseReference favRef = FirebaseDatabase.instance.ref("/users/${user.uid}/favoritos");
      DataSnapshot favoritos = await favRef.get();
       List<Object?> tmpFav = [];
      if(favoritos.value != null){
     tmpFav = (favoritos.value as List<Object?>).toList(growable: true);
      }
      
      if(status){
        tmpFav.add(idObra);
      }else{
        tmpFav.remove(idObra);
      }
      print(tmpFav);
      favoritos.ref.set(tmpFav.asMap().map((key, value) => MapEntry(key.toString(), value)));
    }
  }
}