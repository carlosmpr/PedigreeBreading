import 'package:flutter/material.dart';
import '../../../helpers/models/Breeder.dart';
import '../../../helpers/storage/storage.dart';
import '../../../helpers/api/api.dart';
import 'package:image_picker/image_picker.dart';
import '../../Home/landing.dart';
import 'dart:io';

class UserInformation extends StatefulWidget {
  final List<String> dogInfo;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;
  const UserInformation(
      {Key key,
      this.dogInfo,
      this.imageUrl1,
      this.imageUrl2,
      this.imageUrl3,
      this.imageUrl4})
      : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final formkey = GlobalKey<FormState>();
  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool image4 = false;
  File imageFile1;
  File imageFile2;
  File imageFile3;
  File imageFile4;

  @override
  Widget build(BuildContext context) {
    var info = widget.dogInfo;
    Dog dog = new Dog(info[1]);
    print(info);

    return Scaffold(
      appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 35,
            onPressed: () {
              Navigator.pushReplacementNamed(context, LandingPage.routeName,
                  arguments: 3);
            }),
        SizedBox(
          width: 50,
        ),
        Text("Update information"),
      ])),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Form(
              key: formkey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "I'm a ${info[0]}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Image.network(
                          ('http://clipart-library.com/images/8czno86ji.png'),
                          height: 120,
                          width: 120),
                      Container(
                        height: 25,
                      ),
                      inputName((value) => dog.dogname = value, 'Dogname',
                          '${info[3]}'),
                      inputName((value) => dog.breederType = value,
                          'breederType', '${info[8]}'),
                      inputName(
                          (value) => dog.age = value, 'age', '${info[6]}'),
                      inputName((value) => dog.tempered = value, 'Tempered',
                          '${info[5]}'),
                      inputName((value) => dog.gender = value, 'gender',
                          '${info[4]}'),
                      inputName(
                          (value) => dog.bio = value, 'bio', '${info[7]}'),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                      ),
                      selectImage(),
                      submitButton(dog),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget inputName(_function, label, hint) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        initialValue: hint,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
        ),
        validator: (String value) {
          if (label == "age") {
            if (value.length < 2) {
              return 'Please enter a valid age';
            } else {
              return null;
            }
          }
          if (value.length < 4) {
            return 'Please enter a valid $label minimun length 5';
          }
          return null;
        },
        onSaved: _function,
      ),
    );
  }

  Widget selectImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        image1
            ? InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image1 = true;
                      imageFile1 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    imageFile1,
                    fit: BoxFit.cover,
                  ),
                )),
              )
            : InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image1 = true;
                      imageFile1 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      widget.imageUrl1,
                      fit: BoxFit.cover,
                    ))),
              ),
        image2
            ? InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image2 = true;
                      imageFile2 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    imageFile2,
                    fit: BoxFit.cover,
                  ),
                )),
              )
            : InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image2 = true;
                      imageFile2 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      widget.imageUrl2,
                      fit: BoxFit.cover,
                    ))),
              ),
        image3
            ? InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image3 = true;
                      imageFile3 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    imageFile3,
                    fit: BoxFit.cover,
                  ),
                )),
              )
            : InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image3 = true;
                      imageFile3 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      widget.imageUrl3,
                      fit: BoxFit.cover,
                    ))),
              ),
        image4
            ? InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image4 = true;
                      imageFile4 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                  width: 50,
                  height: 50,
                  child: Image.file(
                    imageFile4,
                    fit: BoxFit.cover,
                  ),
                )),
              )
            : InkWell(
                onTap: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image4 = true;
                      imageFile4 = File(pickedFile.path);
                    });
                  }
                },
                child: (Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      widget.imageUrl4,
                      fit: BoxFit.cover,
                    ))),
              ),
      ],
    );
  }

  Widget submitButton(Dog dog) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            ("Save"),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () async {
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
              try {
                print(dog.gender);
                if (image1) {
                  dog.imageUrl1 =
                      await uploadImage(imageFile1, dog.dogId, "image1");
                } else {
                  dog.imageUrl1 = widget.imageUrl1;
                }

                if (image2) {
                  dog.imageUrl2 =
                      await uploadImage(imageFile2, dog.dogId, "image2");
                } else {
                  dog.imageUrl2 = widget.imageUrl2;
                }

                if (image3) {
                  dog.imageUrl3 =
                      await uploadImage(imageFile3, dog.dogId, "image3");
                } else {
                  dog.imageUrl3 = widget.imageUrl3;
                }
                if (image4) {
                  dog.imageUrl4 =
                      await uploadImage(imageFile4, dog.dogId, "image4");
                } else {
                  dog.imageUrl4 = widget.imageUrl4;
                }

                // dog.imageUrl2 = await uploadImage(imageFile2);
                // dog.imageUrl3 = await uploadImage(imageFile3);
                // dog.imageUrl4 = await uploadImage(imageFile4);

                await updateUserInformation(
                    widget.dogInfo[0],
                    widget.dogInfo[1],
                    widget.dogInfo[2],
                    dog.dogname,
                    dog.gender,
                    dog.tempered,
                    dog.age,
                    dog.bio,
                    dog.breederType,
                    dog.imageUrl1,
                    dog.imageUrl2,
                    dog.imageUrl3,
                    dog.imageUrl4);
                Navigator.pop(context);
              } catch (err) {
                print(err);
              }
            }
          }),
    );
  }
}
