import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notex/api_helper/FirbaseHelper.dart';
import 'package:notex/custom_widgets/CustomWidgets.dart';
import 'package:notex/utils/AssetHelper.dart';
import 'package:notex/utils/ColorsHelper.dart';
import 'package:notex/utils/Constants.dart';
import 'package:notex/utils/NavigatorRoutes.dart';
import 'package:notex/utils/ProgressDialog.dart';

class LoginScreen extends StatelessWidget {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email", "profile"]);
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.only(
          left: Constants.leftRightmargin, right: Constants.leftRightmargin),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Center(child: SvgHelper.appLogo),
              width: double.infinity,
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: RoundedButton(
                  onClick: () => _googleOnclick(),
                  text: "Continue with google",
                  preIcon: SvgHelper.ic_google,
                  backgroundColor: AppColors.googleBackground,
                )),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
              child: RoundedButton(
                onClick: () => _faceBookOnclick(),
                text: "Continue with facebook",
                preIcon: SvgHelper.ic_facebook,
                backgroundColor: AppColors.facebookBackground,
              ),
            )
          ],
        ),
      ),
    ));
  }

  //facebook button click event
  _faceBookOnclick() async {
    ProgressDialog.instanst.showProgress(_context);
    final facebookLogin = FacebookLogin();
    facebookLogin.logInWithReadPermissions(['email']).then((result) {
      _getFacebookToken(result);
    }).catchError((error) {
      ProgressDialog.instanst.dismissDialog(_context);
      print(error.toString());
    });
  }

  //google button click event
  _googleOnclick() {
    ProgressDialog.instanst.showProgress(_context);
    _handleSignIn()
        .then((GoogleSignInAccount account) => {_getGoogleToken(account)})
        .catchError((error)  {
              ProgressDialog.instanst.dismissDialog(_context);
            });
  }

  Future<GoogleSignInAccount> _handleSignIn() {
    try {
      return _googleSignIn.signIn();
    } catch (error) {
      print(error);
      ProgressDialog.instanst.dismissDialog(_context);
      return null;
    }
  }

  _getFacebookToken(result) {
    FacebookAccessToken myToken = result.accessToken;
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: myToken.token);
    _signInToFirebaseAuth(credential);
  }

  _getGoogleToken(GoogleSignInAccount account) async {
    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _signInToFirebaseAuth(credential);
  }

  _signInToFirebaseAuth(AuthCredential credential) {
    FirebaseHelper.instance
        .signInWithCredential(credential)
        .catchError((error) {
      print(error.toString());
      ProgressDialog.instanst.dismissDialog(_context);
    }).then((user) {
      _insertUserData(user);
    });
  }

  _insertUserData(FirebaseUser user) {
    FirebaseHelper.instance.insertUserData(user).then((z) {
      ProgressDialog.instanst.dismissDialog(_context);
      NavigatorRoutes.toHome(_context);
    }).catchError((error)  {ProgressDialog.instanst.dismissDialog(_context);});
  }
}
