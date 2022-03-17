import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpractice/common/commonWidget.dart';
import 'package:taskpractice/view/contact detail.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _userInfoScreenState();
}

class _userInfoScreenState extends State<UserInfoScreen> {
  File? _image;
  TextEditingController name = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController city = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final picker = ImagePicker();

  Future getImage({ImageSource? select}) async {
    final pickedFile = await picker.getImage(source: select!);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('image is:: $_image');
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return Container(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: IconButton(
                                              icon: Icon(Icons.camera),
                                              onPressed: () {
                                                getImage(
                                                    select: ImageSource.camera);
                                                Get.back();
                                              })),
                                      Expanded(
                                          child: IconButton(
                                              icon: Icon(Icons.image),
                                              onPressed: () {
                                                getImage(
                                                    select:
                                                        ImageSource.gallery);
                                                Get.back();
                                              }))
                                    ],
                                  ),
                                );
                              });
                        },
                        child: _image != null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(_image!)),
                                    shape: BoxShape.circle),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xFF009BDF),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  'Add Photo',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ))),
                textFieldBox(
                  label: 'Name',
                  textFieldEdit: commonTextFieldEdit(
                    label: 'Your Name',
                    controllerr: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                textFieldBox(
                  label: 'Designation',
                  textFieldEdit: commonTextFieldEdit(
                    controllerr: designation,
                    label: 'Your Designation',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                textFieldBox(
                  label: 'City',
                  textFieldEdit: commonTextFieldEdit(
                      controllerr: city,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      label: 'Your City'),
                ),
                SizedBox(
                  height: 15,
                ),
                commonButton(
                    buttonName: 'Save',
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        print('validated');
                        _image == null
                            ? Get.snackbar('', 'Please Select Profile Pic')
                            : Get.to(Screen2(
                                name: name.text,
                                designation: designation.text,
                                img: _image,
                                city: city.text));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
