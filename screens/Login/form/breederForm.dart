import 'package:flutter/material.dart';
import '../../../helpers/models/Breeder.dart';
import '../../../helpers/storage/storage.dart';
import '../../../helpers/auth/auth.dart';
import '../../../helpers/api/api.dart';
import 'package:image_picker/image_picker.dart';
import '../../Home/landing.dart';
import '../../../helpers/dialog/dialog.dart';
import 'dart:io';

class BreederForm extends StatefulWidget {
  final String typeOfUser;
  final String email;
  const BreederForm({
    Key key,
    this.typeOfUser,
    this.email,
  }) : super(key: key);

  @override
  _BreederFormState createState() => _BreederFormState();
}

class _BreederFormState extends State<BreederForm> {
  final formkey = GlobalKey<FormState>();
  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool image4 = false;
  File imageFile1;
  File imageFile2;
  File imageFile3;
  File imageFile4;
  String gender;
  String temper;
  String month;
  String age;

  @override
  Widget build(BuildContext context) {
    UserBreeder user = new UserBreeder(widget.typeOfUser, widget.email);
    Dog dog = new Dog(user.dogId);
    final node = FocusScope.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
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
                      widget.typeOfUser,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Image(
                        image: AssetImage('assets/img/icon.png'),
                        height: 60,
                        width: 60),
                    Container(
                      height: 25,
                    ),
                    inputName(
                        (value) => user.username = value, 'Username', node),
                    Container(
                      height: 10,
                    ),
                    inputName(
                        (value) => user.lastname = value, 'Fullname', node),
                    Container(
                      height: 10,
                    ),
                    inputName((value) => dog.dogname = value, 'Dogname', node),
                    Container(
                      height: 25,
                    ),
                    inputName((value) => dog.zipcode = value, 'Zipcode', node),
                    Container(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender'),
                              DropdownButton<String>(
                                hint: Text('Select Gender'),
                                value: gender,
                                icon: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                      ),
                                      const Icon(Icons.arrow_downward)
                                    ],
                                  ),
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.grey),
                                underline:
                                    Container(height: 2, color: Colors.grey),
                                onChanged: (newValue) {
                                  setState(() {
                                    gender = newValue;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child:
                                inputName((value) => age = value, 'Age', node)),
                        Container(
                          width: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.184,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: DropdownButton<String>(
                            hint: Text('year or month'),
                            value: month,
                            icon: Container(
                              child: Row(
                                children: [
                                  Container(),
                                  const Icon(Icons.arrow_downward)
                                ],
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.grey),
                            underline: Column(
                              children: [
                                Container(height: 2, color: Colors.grey),
                              ],
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                month = newValue;
                              });
                            },
                            items: <String>['Month', 'Year']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Temperament'),
                              DropdownButton<String>(
                                hint: Text('Select the Temperament'),
                                value: temper,
                                icon: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                      ),
                                      const Icon(Icons.arrow_downward)
                                    ],
                                  ),
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.grey),
                                underline:
                                    Container(height: 2, color: Colors.grey),
                                onChanged: (newValue) {
                                  setState(() {
                                    temper = newValue;
                                  });
                                },
                                items: <String>[
                                  'Friendly ',
                                  'Playful',
                                  'Active',
                                  'Calm'
                                      'Social',
                                  'Smart',
                                  'Loyal',
                                  'Affectionate',
                                  'Aggressive',
                                  'Submissive'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    inputName(
                        (value) => dog.breederType = value, 'Breed', node),
                    Container(
                      height: 10,
                    ),
                    inputName((value) => dog.bio = value, 'Bio', node),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                    ),
                    selectImage(),
                    submitButton(user, dog),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget inputName(_function, label, node) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        keyboardType: label == 'Age' || label == 'Zipcode'
            ? (TextInputType.number)
            : (TextInputType.emailAddress),
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
        ),
        onEditingComplete: () =>
            label == 'Bio' ? (node.unfocus()) : (node.nextFocus()),
        validator: (String value) {
          if (label == "Zipcode") {
            if (value.length == 5) {
              return 'Please enter a valid zipcode';
            }
            return null;
          }
          if (label == "Age") {
            if (value.length < 1) {
              return 'Please enter a valid age';
            }
            return null;
          }
          if (value.length < 2) {
            return 'Please enter a valid $label';
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
            ? (Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                width: 60,
                height: 60,
                child: Image.file(
                  imageFile1,
                  fit: BoxFit.fill,
                ),
              ))
            : Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                    iconSize: 60,
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: () async {
                      PickedFile pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 600,
                        maxHeight: 600,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          image1 = true;
                          imageFile1 = File(pickedFile.path);
                        });
                      }
                    })),
        image2
            ? (Container(
                width: 50,
                height: 50,
                child: Image.file(
                  imageFile2,
                  fit: BoxFit.cover,
                ),
              ))
            : IconButton(
                iconSize: 50,
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                    maxHeight: 600,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image2 = true;
                      imageFile2 = File(pickedFile.path);
                    });
                  }
                }),
        image3
            ? (Container(
                width: 50,
                height: 50,
                child: Image.file(
                  imageFile3,
                  fit: BoxFit.cover,
                ),
              ))
            : IconButton(
                iconSize: 50,
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                    maxHeight: 600,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image3 = true;
                      imageFile3 = File(pickedFile.path);
                    });
                  }
                }),
        image4
            ? (Container(
                width: 50,
                height: 50,
                child: Image.file(
                  imageFile4,
                  fit: BoxFit.cover,
                ),
              ))
            : IconButton(
                iconSize: 50,
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () async {
                  PickedFile pickedFile = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                    maxHeight: 600,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      image4 = true;
                      imageFile4 = File(pickedFile.path);
                    });
                  }
                }),
      ],
    );
  }

  Widget submitButton(user, dog) {
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
              dog.gender = gender;
              dog.tempered = temper;
              dog.age = '$age $month';
              var token = await fetchSession();
              user.userId = await currentUser();
              if (image1 && image2 && image3 && image4) {
                loadingDialog(context);
                try {
                  dog.imageUrl1 =
                      await uploadImage(imageFile1, user.dogId, "image1");
                  dog.imageUrl2 =
                      await uploadImage(imageFile2, user.dogId, "image2");
                  dog.imageUrl3 =
                      await uploadImage(imageFile3, user.dogId, "image3");
                  dog.imageUrl4 =
                      await uploadImage(imageFile4, user.dogId, "image4");
                } catch (err) {
                  print(err);
                }

                await getHttp(token, user, dog);
                Navigator.pop(context);

                Navigator.pushReplacementNamed(context, LandingPage.routeName);
              } else {
                showMaterialDialog(
                    context, "Error", "you need to provide all photos");
              }
            }
          }),
    );
  }
}
