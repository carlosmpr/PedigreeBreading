import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';

uploadImage(file, dogId, text) async {
  final key = '$dogId-$text';
  Map<String, String> metadata = <String, String>{};
  metadata['name'] = "$dogId";
  metadata['desc'] = ' Dog image of user $dogId  number $text';

  try {
    UploadFileResult result =
        await Amplify.Storage.uploadFile(key: key, local: file);
    return (result.key);
  } on StorageException catch (e) {
    print(e.message);
  }
}

getImageurl(key) async {
  try {
    GetUrlResult resultUrl = await Amplify.Storage.getUrl(key: key);
    return (resultUrl.url);
  } on StorageException catch (e) {
    print(e.message);
  }
}
