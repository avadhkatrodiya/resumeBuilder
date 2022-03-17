import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskpractice/common/validation_controller.dart';

ValidationController validationController = Get.find();
Container textFieldBox({String? label, Widget? textFieldEdit}) {
  return Container(
    width: Get.width,
    child: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          textFieldEdit!,
        ],
      ),
    ),
  );
}

Container commonTextFieldEdit({
  TextInputType? keyType,
  Validator? validator,
  String? label,
  int? inputLength,
  bool readOnly = false,
  TextEditingController? controllerr,
  String? regularExpression,
}) {
  return Container(
    // width: 330,
    // height: Get.height * 0.07,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Color(0xfff2f3f2)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        keyboardType: keyType,
        controller: controllerr,
        readOnly: readOnly,
        inputFormatters: regularExpression != null
            ? [
                LengthLimitingTextInputFormatter(inputLength),
                FilteringTextInputFormatter.allow(RegExp(regularExpression))
              ]
            : [
                LengthLimitingTextInputFormatter(inputLength),
              ],
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    ),
  );
}

Padding commonButton({String? buttonName, OnTap? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.07,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
            colors: [
              Color(0xFF009BDF),
              Color(0xff0072BB),
            ],
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),

          // color: Color(0xff0072bb)
        ),
        child: Center(
          child: Text(
            buttonName!,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
          ),
        ),
      ),
    ),
  );
}

typedef OnTap = Function();
typedef Validator = String? Function(String? str);
typedef OnChange = Function(String str);
