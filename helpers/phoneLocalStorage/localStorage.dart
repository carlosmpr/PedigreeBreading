import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

saveUser(userType, userId, dogId, dogname, gender, tempered, age, bio,
    breederType, imageUrl1, imageUrl2, imageUrl3, imageUrl4) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> infoLiset = [
    userType,
    userId,
    dogId,
    dogname,
    gender,
    tempered,
    age,
    bio,
    breederType,
    imageUrl1,
    imageUrl2,
    imageUrl3,
    imageUrl4,
  ];

  try {
    await prefs.setStringList('data', infoLiset);
    return true;
  } catch (e) {
    return false;
  }
}
