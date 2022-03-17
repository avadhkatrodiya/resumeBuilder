import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskpractice/common/commonWidget.dart';
import 'package:taskpractice/common/style.dart';
import 'package:taskpractice/view/college.dart';

class Screen2 extends StatefulWidget {
  final String? name;
  final String? designation;
  final String? city;
  final File? img;

  const Screen2({Key? key, this.name, this.designation, this.img, this.city})
      : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController linkedinIn = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: FileImage(widget.img!)),
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.name}',
                        style: FontTextStyle.w7S22Black
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text('${widget.designation}'),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Contact',
                style: FontTextStyle.w7S22Black,
              ),
              textFieldBox(
                  label: 'email',
                  textFieldEdit: commonTextFieldEdit(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email cannot be empty";
                        }
                        return null;
                      },
                      keyType: TextInputType.emailAddress,
                      regularExpression: r"([a-zA-Z0-9_@.])",
                      controllerr: email)),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phone',
                      style: FontTextStyle.w7S22Black
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfff2f3f2)),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          // prefixIcon: Icon(Icons.phone)
                          prefixIcon: CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              setState(() {
                                countryCodeController.text =
                                    countryCode.toString();
                                // print('......$country');
                                // country = countryCodeController.text;
                                print('*****${countryCodeController.text}');
                              });
                            },

                            // onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'US',
                            favorite: ['+91', 'IN'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            showFlag: true,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          )
                          // prefixIcon: Icon(Icons.call_outlined),
                          ),
                      inputFormatters: r"[0-9]" != null
                          ? [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"))
                            ]
                          : [
                              LengthLimitingTextInputFormatter(10),
                            ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Number cannot be empty";
                        } else if (value.length < 10) {
                          return "Number length should be atleast 10";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              textFieldBox(
                  label: 'LinkedIn ID',
                  textFieldEdit: commonTextFieldEdit(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "id cannot be empty";
                        }
                        return null;
                      },
                      keyType: TextInputType.text,
                      controllerr: linkedinIn)),
              commonButton(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      Get.to(collegeScreen(
                        name: widget.name,
                        designation: widget.designation,
                        city: widget.city,
                        img: widget.img,
                        email: email.text,
                        phone: phoneController.text,
                        linkedInID: linkedinIn.text,
                      ));
                    }
                  },
                  buttonName: "Save")
            ],
          ),
        ),
      ),
    ));
  }
}
