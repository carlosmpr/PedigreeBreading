import './Breeder.dart';

class User {
  final String email;
  final String password;

  String get mail {
    return email;
  }

  String get pass {
    return password;
  }

  User(this.email, this.password);
}

class DogInfo {
  final List<dynamic> pictures;
  var ingoDog;
  final int currentPic;

  DogInfo(this.pictures, this.ingoDog, this.currentPic);
}

class UserChat {
  final int chatId;
  final String username;

  UserChat(this.chatId, this.username);
}
