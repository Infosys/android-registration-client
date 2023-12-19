import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:registration_client/pigeon/biometrics_pigeon.dart';
import 'package:registration_client/provider/registration_task_provider.dart';
import 'package:registration_client/utils/app_config.dart';
import 'package:registration_client/utils/app_style.dart';

import '../../../model/field.dart';
import '../../../provider/global_provider.dart';
import 'custom_label.dart';

class AgeDateControl extends StatefulWidget {
  const AgeDateControl(
      {super.key, required this.validation, required this.field});

  final RegExp validation;
  final Field field;

  @override
  State<AgeDateControl> createState() => _AgeDateControlState();
}

class _AgeDateControlState extends State<AgeDateControl> {
  TextEditingController dayController = TextEditingController();

  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final dayFocus = FocusNode();
  final monthFocus = FocusNode();
  final yearFocus = FocusNode();

  @override
  void initState() {
    _getSavedDate();
    super.initState();
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();

    dayFocus.dispose();
    monthFocus.dispose();
    yearFocus.dispose();

    super.dispose();
  }

  void focusNextField(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _removeFocusFromAll(String currentTab) {
    switch (currentTab) {
      case "day":
        monthFocus.unfocus();
        yearFocus.unfocus();
        break;
      case "month":
        dayFocus.unfocus();
        yearFocus.unfocus();
        break;
      case "year":
        dayFocus.unfocus();
        monthFocus.unfocus();
        break;
      default:
    }
  }

  int calculateYearDifference(DateTime date1, DateTime date2) {
    int yearDifference = date2.year - date1.year;
    if (date1.month > date2.month ||
        (date1.month == date2.month && date1.day > date2.day)) {
      yearDifference--;
    }
    return yearDifference;
  }

  _calculateAgeFromDOB() {
    DateTime date = DateTime.parse(
        "${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}");
    DateTime currentDate = DateTime.now();
    if (date.compareTo(currentDate) < 0) {
      ageController.text =
          calculateYearDifference(date, currentDate).abs().toString();
    } else {
      ageController.text = "";
    }
  }

  String? fieldValidation(value, message) {
    try {
      String targetDateString = widget.field.format ??
          "yyyy/MM/dd"
              .replaceAll('dd', dayController.text.padLeft(2, '0'))
              .replaceAll('MM', monthController.text.padLeft(2, '0'))
              .replaceAll('yyyy', yearController.text);

      if (value == "") {
        return 'Empty';
      }
      if (!widget.validation.hasMatch(targetDateString)) {
        return message;
      }
      return null;
    } catch (e) {
      log("error");
      return "";
    }
  }

  _invalidDateText() {
    DateTime date = DateTime.parse(
        "${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}");
    DateTime currentDate = DateTime.now();
    if (date.compareTo(currentDate) > 0) {
      return "Invalid date!";
    }
    return null;
  }

  void saveData() {
    String targetDateString = widget.field.format ??
        "yyyy/MM/dd"
            .replaceAll('dd', dayController.text.padLeft(2, '0'))
            .replaceAll('MM', monthController.text.padLeft(2, '0'))
            .replaceAll('yyyy', yearController.text);

    context.read<RegistrationTaskProvider>().setDateField(
          widget.field.id ?? "",
          widget.field.subType ?? "",
          dayController.text.padLeft(2, '0'),
          monthController.text.padLeft(2, '0'),
          yearController.text,
        );
    context.read<GlobalProvider>().setInputMapValue(
          widget.field.id!,
          targetDateString,
          context.read<GlobalProvider>().fieldInputValue,
        );
    BiometricsApi().getAgeGroup().then((value) {
      context.read<GlobalProvider>().ageGroup = value;
    });
  }

  void _getSavedDate() {
    if (context
        .read<GlobalProvider>()
        .fieldInputValue
        .containsKey(widget.field.id)) {
      String targetDateFormat = widget.field.format ?? "yyyy/MM/dd";

      String savedDate =
          context.read<GlobalProvider>().fieldInputValue[widget.field.id];
      DateTime parsedDate = DateFormat(targetDateFormat).parse(savedDate);
      dayController.text = parsedDate.day.toString().padLeft(2, '0');
      monthController.text = parsedDate.month.toString().padLeft(2, '0');
      yearController.text = parsedDate.year.toString();
      ageController.text = calculateYearDifference(
              DateTime.parse(
                  "${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}"),
              DateTime.now())
          .abs()
          .toString();
    }
  }

  void _getDateFromAge(String value) {
    int age = int.parse(value);
    DateTime currentDate = DateTime.now();
    DateTime calculatedDate = DateTime(currentDate.year - age, 1, 1);
    dayController.text = calculatedDate.day.toString().padLeft(2, '0');
    monthController.text = calculatedDate.month.toString().padLeft(2, '0');
    yearController.text = calculatedDate.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Card(
      elevation: 5,
      color: pureWhite,
      margin: EdgeInsets.symmetric(
          vertical: 1.h, horizontal: isPortrait ? 16.w : 0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(field: widget.field),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () => _removeFocusFromAll("day"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          String? valid = fieldValidation(value, "dd");
                          if (valid == null) {
                            return _invalidDateText();
                          }
                          return valid;
                        },
                        onChanged: (value) {
                          if (value.length == 2 &&
                              monthController.text.length == 2 &&
                              yearController.text.length == 4) {
                            _calculateAgeFromDOB();
                          } else {
                            ageController.text = "";
                          }
                          if (value.length >= 2) {
                            focusNextField(dayFocus, monthFocus);
                          }
                          saveData();
                        },
                        maxLength: 2,
                        focusNode: dayFocus,
                        keyboardType: TextInputType.number,
                        controller: dayController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintStyle: const TextStyle(
                              color: AppStyle.appBlackShade3, fontSize: 14),
                          counterText: "",
                          hintText: 'DD',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9B9B9F), width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: TextFormField(
                        onTap: () => _removeFocusFromAll("month"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          String? valid = fieldValidation(value, "MM");
                          if (valid == null) {
                            return _invalidDateText();
                          }
                          return valid;
                        },
                        onChanged: (value) {
                          if (value.length == 2 &&
                              monthController.text.length == 2 &&
                              yearController.text.length == 4) {
                            _calculateAgeFromDOB();
                          } else {
                            ageController.text = "";
                          }
                          if (value.length >= 2) {
                            focusNextField(monthFocus, yearFocus);
                          }
                          saveData();
                        },
                        maxLength: 2,
                        focusNode: monthFocus,
                        keyboardType: TextInputType.number,
                        controller: monthController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintStyle: const TextStyle(
                              color: AppStyle.appBlackShade3, fontSize: 14),
                          counterText: "",
                          hintText: 'MM',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9B9B9F), width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: TextFormField(
                        validator: (value) {
                          String? valid = fieldValidation(value, "yyyy");
                          if (valid == null) {
                            return _invalidDateText();
                          }
                          return valid;
                        },
                        onChanged: (value) {
                          if (value.length == 4 &&
                              dayController.text.length == 2 &&
                              monthController.text.length == 2) {
                            _calculateAgeFromDOB();
                          } else {
                            ageController.text = "";
                          }
                          saveData();
                        },
                        onTap: () => _removeFocusFromAll("year"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 4,
                        focusNode: yearFocus,
                        controller: yearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintStyle: const TextStyle(
                              color: AppStyle.appBlackShade3, fontSize: 14),
                          counterText: "",
                          hintText: 'YYYY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9B9B9F), width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text("OR"),
                    const SizedBox(width: 12),
                    Flexible(
                      child: TextFormField(
                        // readOnly: true,
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != "") {
                            _getDateFromAge(value);
                            saveData();
                          } else {
                            dayController.text = "";
                            monthController.text = "";
                            yearController.text = "";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintStyle: const TextStyle(
                              color: AppStyle.appBlackShade3, fontSize: 14),
                          hintText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9B9B9F), width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
