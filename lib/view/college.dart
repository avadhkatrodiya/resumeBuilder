import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpractice/common/commonWidget.dart';
import 'package:taskpractice/common/style.dart';
import 'package:taskpractice/main.dart';
import 'package:taskpractice/model/data.dart';
import 'package:taskpractice/view/pdfview.dart';

class collegeScreen extends StatefulWidget {
  final String? name;
  final String? designation;
  final String? city;
  final File? img;
  final String? email;
  final String? phone;
  final String? linkedInID;
  const collegeScreen(
      {Key? key,
      this.name,
      this.designation,
      this.city,
      this.img,
      this.email,
      this.phone,
      this.linkedInID})
      : super(key: key);

  @override
  _collegeScreenState createState() => _collegeScreenState();
}

class _collegeScreenState extends State<collegeScreen> {
  @override
  String? startDateis;
  String? endDateis;
  TextEditingController university = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController course = TextEditingController();
  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1965),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        startDateis = DateFormat('yyyy-MM-dd ').format(pickedDate);
        print('startDate:::$startDateis');
        // using state so that the UI will be rerendered when date is picked
        // startDate = pickedDate;
      });
    });
  }

  void _endDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1965),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        endDateis = DateFormat('yyyy-MM-dd ').format(pickedDate);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Add Collage',
                style: FontTextStyle.w7S22Black,
              ),
              SizedBox(height: 50),
              textFieldBox(
                label: 'Name University',
                textFieldEdit: commonTextFieldEdit(
                  label: 'Name of your university',
                  controllerr: university,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "university cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              textFieldBox(
                label: 'Website',
                textFieldEdit: commonTextFieldEdit(
                    controllerr: website,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "website cannot be empty";
                      }
                      return null;
                    },
                    label: 'University Website'),
              ),
              SizedBox(
                height: 15,
              ),
              textFieldBox(
                label: 'Course',
                textFieldEdit: commonTextFieldEdit(
                    controllerr: course,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Course cannot be empty";
                      }
                      return null;
                    },
                    label: 'What course you took?'),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Start Date'),
                      ),
                      Text(
                        startDateis != null ? startDateis.toString() : '',
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _endDatePicker,
                        child: const Text('End Date'),
                      ),
                      Text(
                        endDateis != null ? endDateis.toString() : '',
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              commonButton(
                  buttonName: 'Save',
                  onTap: () {
                    print('validate');
                    MyCompletedData obj = MyCompletedData();
                    obj.phone = widget.phone;
                    obj.img = widget.img!.path;
                    obj.designation = widget.designation;
                    obj.email = widget.email;
                    obj.name = widget.name;
                    obj.linkedInId = widget.linkedInID;
                    obj.city = widget.city;
                    obj.university = university.text;
                    obj.website = website.text;
                    obj.course = course.text;
                    obj.startDate = startDateis;
                    obj.endDate = endDateis;

                    // Utility.listCompletedData.add(obj);
                    log(jsonEncode(obj));
                    String da = jsonEncode(obj);
                    pref!.setString('completedRoomList', da);
                    print(
                        'complete List Room:${pref!.getString('completedRoomList')}');

                    return generateAndPrintArabicPdf();
                  })
              // Container(
              //   padding: const EdgeInsets.all(30),
              //   child: Text(
              //     _selectedDate != null
              //         ? _selectedDate.toString()
              //         : 'No date selected!',
              //     style: const TextStyle(fontSize: 30),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
