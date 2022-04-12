import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;
FirebaseFirestore kFirebaseFirestore = FirebaseFirestore.instance;

class RegisterRepo {
  static Future<void> createUserEmail({String? email, String? pass}) async {
    try {
      await kFirebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: pass!);
    } catch (e) {
      print("==========e_Register============$e}");
    }
  }

  static Future<void> emailLogin({String? email, String? pass}) async {
    try {
      await kFirebaseAuth.signInWithEmailAndPassword(
          email: email!, password: pass!);
    } catch (e) {
      CommonSnackBar.showSnackBar(successStatus: false, msg: '$e');
    }
  }

  static Future<void> currantUser() async {
    // await PreferenceManager.setUId(kFirebaseAuth.currentUser!.uid);
    // await PreferenceManager.setEmailId(kFirebaseAuth.currentUser!.email);

    // print("=======uid======${PreferenceManager.getUId()}");
    // print("=======uid======${PreferenceManager.setEmailId}");
  }

  static Future<void> logOut() async {
    kFirebaseAuth.signOut();
    print("====Log Out====");
  }

  // static Future updateEmail({String? value}) async {
  //   // value is the email user inputs in a textfield and is validated
  //   userData.updateEmail(value);
  // }
  static Future<void> resetEmail({String? newEmail}) async {
    var message;
    var firebaseUser = kFirebaseAuth.currentUser!;
    print("===Current User=======${firebaseUser}");
    firebaseUser.updateEmail("");
    await firebaseUser
        .updateEmail(newEmail!)
        // dIJvEteeWeWoHGIiYWOcfkrZt1B3
        // dIJvEteeWeWoHGIiYWOcfkrZt1B3
        .then(
          (value) => message = 'Success',
        )
        .catchError((onError) => message = 'error');
    return message;
  }
  // static Future<void> resetPhoneNumber({String? newEmail}) async {
  //   var message;
  //   var firebaseUser = kFirebaseAuth.currentUser!;
  //   print("===Current User=======${firebaseUser}");
  //
  //
  //   firebaseUser.updateEmail("");
  //   await firebaseUser
  //       .updatePhoneNumber();
  //       // dIJvEteeWeWoHGIiYWOcfkrZt1B3
  //       // dIJvEteeWeWoHGIiYWOcfkrZt1B3
  //       .then(
  //         (value) => message = 'Success',
  //       )
  //       .catchError((onError) => message = 'error');
  //   return message;
  // }

// Future<void> UpdateData() async {
//   String imageUrl = await uploadImageToFirebase(
//       contex: context,
//       file: _image,
//       fileName: '${email.text}_profile_update.png');
//   print(imageUrl);
//   uploadImage = imageUrl;
//   await userCollection.doc(PreferenceManager.getUId()).get();
//   userCollection
//       .doc(PreferenceManager.getUId())
//       .update({
//     'email': email.text,
//     'firstname': fname.text,
//     'lastname': lname.text,
//     'phoneno': phn.text,
//     'gender': _character == SingingCharacter.male ? "Male" : "Female",
//     'city': _dropDownValue,
//     'imageProfile': imageUrl,
//
//     // 'hobbies': values == 'singing' ? true : false,
//     // 'hobbies': value1,
//     // 'hobbies': value2,
//   })
//       .then((value) => print('success'))
//       .catchError((e) => print(e));
// }
  static Future<void> changePassword({String? password}) async {
    var user = await FirebaseAuth.instance.currentUser!;
    String? email = user.email;

    //Create field for user to input old password

    //pass the password here
    String password = "password";
    String newPassword = "password";

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password,
      );

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
