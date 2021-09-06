import 'package:http/http.dart' as http;
import '../auth/auth.dart';
import '../models/Breeder.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../phoneLocalStorage/localStorage.dart';

String url = "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev";

getHttp(token, UserBreeder user, Dog dog) async {
  var email = await currentUseremail();
  Map data = {
    "user": {
      "userType": user.userType,
      "userId": user.userId,
      "email": email,
      "username": "${user.username} ${user.lastname}",
      "dogId": user.userId
    },
    "dog": {
      "zipcode": dog.zipcode,
      "dogname": dog.dogname,
      "age": dog.age,
      "gender": dog.gender,
      "tempered": dog.tempered,
      "bio": dog.bio,
      "breederType": dog.breederType,
      "imageUrl3": dog.imageUrl3,
      "imageUrl1": dog.imageUrl1,
      "imageUrl4": dog.imageUrl4,
      "imageUrl2": dog.imageUrl2
    }
  };
  saveUser(
    user.userType,
    user.dogId,
    dog.zipcode,
    dog.dogname,
    dog.gender,
    dog.tempered,
    dog.age,
    dog.bio,
    dog.breederType,
    dog.imageUrl1,
    dog.imageUrl2,
    dog.imageUrl3,
    dog.imageUrl4,
  );
  String body = json.encode(data);

  Map<String, String> requestHeaders = {'Bearer': '$token'};

  try {
    var response = await http.post(
        "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/users",
        headers: requestHeaders,
        body: body);

    print(response.body);
  } catch (err) {
    print(err);
  }
}

getAllInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);
  print('information here $getuser');
  if (getuser.length >= 0) {
    print("no user save data finding");
    var data = await userInformation();
    print(data);
    await saveUser(
        data[0]['userType'],
        data[0]['dogId'],
        data[0]['zipcode'],
        data[0]['dogname'],
        data[0]['gender'],
        data[0]['tempered'],
        data[0]['age'],
        data[0]['bio'],
        data[0]['breederType'],
        data[0]['imageUrl1'],
        data[0]['imageUrl2'],
        data[0]['imageUrl3'],
        data[0]['imageUrl4']);

    getuser = (prefs.getStringList('data') ?? [""]);
  }

  print('information here $getuser');
  Map uuid = {"user": getuser[1]};
  String body = json.encode(uuid);

  try {
    var response = await http.post(
        "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/Dog",
        body: body);

    print(response);

    var data = json.decode(response.body);

    return data['body'];
  } catch (e) {
    print(e);
  }
}

getLikeInfo(user2) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);

  Map uuid = {"userId1": getuser[1], "userId2": user2};

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/likes",
      body: body);

  var data = json.decode(response.body);

  print(data['body']);

  return data['body'];
}

getMatchInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);

  Map uuid = {"userId1": getuser[1]};
  print(getuser[1]);

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/likes/match",
      body: body);

  var data = json.decode(response.body);

  print(data);

  return data;
}

chatRoom(user2, photo, username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);
  print(user2);

  Map uuid = {
    "userId1": getuser[1],
    "user1Name": getuser[3],
    "photo1": getuser[9],
    "userId2": user2,
    "photo2": photo,
    "user2Name": username
  };

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/chat",
      body: body);

  var data = json.decode(response.body);

  print(data['body']);

  return data['body'][0];
}

getChatInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);

  Map uuid = {"getChatID": getuser[1]};
  print(getuser[1]);

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/chat",
      body: body);

  var data = json.decode(response.body);

  print(data);

  return data['body'];
}

sendMessage(chatId, message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> getuser = (prefs.getStringList('data') ?? [""]);

  Map uuid = {"chatId": '$chatId', "userId": getuser[1], "message": message};

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/message",
      body: body);

  var data = json.decode(response.body);

  return data['body'];
}

getMessage(chatId) async {
  Map uuid = {"chatId": '$chatId'};

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/message",
      body: body);

  var data = json.decode(response.body);

  return data['body'];
}

userInformation() async {
  var userId = await currentUser();
  Map uuid = {"userId": userId};
  print(userId);
  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/Dog",
      body: body);

  var data = json.decode(response.body);
  print(data);

  return data['body'];
}

updateUserInformation(userType, dogId, zipcode, dogname, gender, tempered, age,
    bio, breederType, imageUrl1, imageUrl2, imageUrl3, imageUrl4) async {
  saveUser(userType, dogId, zipcode, dogname, gender, tempered, age, bio,
      breederType, imageUrl1, imageUrl2, imageUrl3, imageUrl4);
  Map uuid = {
    "updateUser": 1,
    "dog": {
      "userType": userType,
      "dogId": dogId,
      "zipcode": zipcode,
      "dogname": dogname,
      "gender": gender,
      "tempered": tempered,
      "age": age,
      "bio": bio,
      "breederType": breederType,
      "imageUrl1": imageUrl1,
      "imageUrl2": imageUrl2,
      "imageUrl3": imageUrl3,
      "imageUrl4": imageUrl4
    }
  };

  String body = json.encode(uuid);
  var response = await http.post(
      "https://5f56s8d0jb.execute-api.us-east-1.amazonaws.com/dev/Dog",
      body: body);

  var data = json.decode(response.body);
  print(data);

  return data['body'];
}
