import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

Future<bool> registeruser(email, password) async {
  try {
    Map<String, String> userAttributes = {
      'email': email,
      // additional attributes as needed
    };
    SignUpResult res = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    return true;
  } on AuthException catch (e) {
    return false;
  }
}

Future<bool> confirnmCode(code, email) async {
  try {
    SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: email, confirmationCode: code);

    print(res.isSignUpComplete);
    return true;
  } on AuthException catch (e) {
    return false;
  }
}

fetchSession() async {
  try {
    CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true));
    return (res.userPoolTokens.idToken);
  } on AuthException catch (e) {
    print(e.message);
  }
}

signinUser(email, password) async {
  try {
    SignInResult res = await Amplify.Auth.signIn(
      username: email,
      password: password,
    );
    print(res.isSignedIn);
    return (res.isSignedIn);
  } on AuthException catch (e) {
    print(e.message);
  }
}

void signout() async {
  try {
    Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
}

currentUser() async {
  var user = await Amplify.Auth.getCurrentUser();
  return user.userId;
}

currentUseremail() async {
  var user = await Amplify.Auth.getCurrentUser();
  return user.username;
}
