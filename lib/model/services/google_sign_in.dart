import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/by_default_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  BottomController _bottomController = Get.find();
  RegisterRelasiyaReqModel _user = RegisterRelasiyaReqModel();

  var gooGle = GoogleSignIn();

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await gooGle.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      var name = googleSignInAccount.displayName;
      var gooGleId = googleSignInAccount.id;
      var getEmail = googleSignInAccount.email;
      PreferenceManager.setLoginValue(getEmail);
      PreferenceManager.setTokenId(_auth.currentUser!.uid.toString());
      print('-------getTokenId--------${PreferenceManager.getTokenId()}');
      String fname = googleSignInAccount.displayName!
          .substring(0, googleSignInAccount.displayName!.lastIndexOf(' '));
      print("=====================================fname===google===$fname");

      String lname = googleSignInAccount.displayName!
          .substring(googleSignInAccount.displayName!.lastIndexOf(' ') + 1);
      CommonSnackBar.showSnackBar(msg: 'Login successful', successStatus: true);
      PreferenceManager.setLoginType('google');
      Future.delayed(Duration(seconds: 2), () {
        // Get.offAll(NavigationBarScreen());
        navigatorScreen();
      });
      print("=====================================lname===google===$lname");
    } catch (e) {
      Get.showSnackbar(GetBar(
        message: 'Google login failed',
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> signOutGoogle() async {
    await gooGle.signOut();

    print("User Signed Out");
  }

  bool? exist;

  Future<bool?> checkExist() async {
    try {
      await FirebaseFirestore.instance
          .collection("UserAllData")
          .doc(PreferenceManager.getTokenId())
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      print('-----------exist--- $exist');
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  var isStatusData;
  navigatorScreen() async {
    // await checkExist();

    await checkExist();
    print('---------exist $exist');
    if (exist == true) {
      var collection = FirebaseFirestore.instance
          .collection('UserAllData')
          .doc(PreferenceManager.getTokenId());
      var querySnapshot = await collection.get();
      print('--------name--------2${querySnapshot['name']}');

      if (querySnapshot['profileDetails'] == true) {
        PreferenceManager.setFnameId(querySnapshot['name']);
        PreferenceManager.setImage(querySnapshot['userImage']);
        PreferenceManager.setNotSearchHandel(querySnapshot['user_name']);
        FirebaseFirestore.instance
            .collection('UserAllData')
            .doc(querySnapshot['auth_Token'])
            .update({'fcm_token': PreferenceManager.getFcmToken()});
        _user.emailOrPhone = '${PreferenceManager.getTokenId()}@gmail.com';
        _user.password = PreferenceManager.getTokenId();
        RelaysiaAuthResponse _responseR = await RegisterRelysiaRepo()
            .registerRelysiaRepo(isLogin: true, body: _user.toJson());
        if (_responseR.statusCode == 200) {
          PreferenceManager.setRelasiyaToken(_responseR.data!.token!);
          if (querySnapshot['isCharges'] == false) {
            Get.offAll(AppCharges());
          } else {
            Get.offAll(NavigationBarScreen());
          }
        } else {
          CommonSnackBar.showSnackBar(
              msg: 'Details not update', successStatus: false);
        }
      } else {
        Get.offAll(ByDefaultScreen());
      }
    } else {
      Get.offAll(ByDefaultScreen());
    }
  }
}
