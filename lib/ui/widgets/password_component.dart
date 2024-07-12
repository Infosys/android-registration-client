/*
 * Copyright (c) Modular Open Source Identity Platform
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
*/

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:registration_client/utils/app_config.dart';
import 'package:registration_client/utils/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/biometric_attribute_data.dart';
import '../../pigeon/biometrics_pigeon.dart';
import '../../provider/biometric_capture_control_provider.dart';


class PasswordComponent extends StatefulWidget {
  const PasswordComponent({
    Key? key,
    required this.onTapLogin,
    required this.onTapBack,
    required this.onChanged,
    required this.isLoggingIn,
    required this.isDisabled,
    required this.isMobile,
  }) : super(key: key);

  final VoidCallback onTapLogin;
  final VoidCallback onTapBack;
  final Function onChanged;
  final bool isLoggingIn;
  final bool isDisabled;
  final bool isMobile;

  @override
  State<PasswordComponent> createState() => _PasswordComponentState();
}

class _PasswordComponentState extends State<PasswordComponent> {
  String chosenValue = "Password";
  BiometricAttributeData? biometricAttributeData;
  BiometricCaptureControlProvider? biometricCaptureControlProvider;



  setInitialState() {
    context.read<BiometricCaptureControlProvider>().biometricAttribute = chosenValue;
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Iris") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().iris;
    }
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Right Hand") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().rightHand;
    }
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Left Hand") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().leftHand;
    }
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Thumbs") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().thumbs;
    }
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Face") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().face;
    }
    if (context.read<BiometricCaptureControlProvider>().biometricAttribute ==
        "Exception") {
      biometricAttributeData =
          context.read<BiometricCaptureControlProvider>().exception;
    }
  }

  Widget authenticateButton() {
    return InkWell(
      onTap: ()async {
        debugPrint("Before Switch from dp: ${biometricAttributeData!.title}");
        List<Uint8List?> tempImageList = [];
        await BiometricsApi().invokeDiscoverSbi("operatorBiometrics",
            biometricAttributeData!.title.replaceAll(" ", ""));
        await BiometricsApi()
            .getBestBiometrics("operatorBiometrics",
            biometricAttributeData!.title.replaceAll(" ", ""))
            .then((value) {});
        await BiometricsApi()
            .extractImageValues("operatorBiometrics",
            biometricAttributeData!.title.replaceAll(" ", ""))
            .then((value) {
          tempImageList = value;
        });
        showCustomAlert(tempImageList);
      },
      child: Container(
        height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
        decoration: BoxDecoration(
          color: appSolidPrimary,
          border: Border.all(
            width: 1.w,
            color: appBlueShade1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            "AUTHENTICATE",
            style: widget.isMobile && !isMobileSize
                ? AppTextStyle.tabletPortraitButtonText
                : AppTextStyle.mobileButtonText,
          ),
        ),
      ),
    );
  }

   showSuccessDialog(){
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          height: 474.h,
          width: 574.w,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
                width: double.infinity,
              ),
              SvgPicture.asset(
                  "assets/svg/success_message_icon.svg"),
              Text("Successfully Verified!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: semiBold,
                    color: const Color(0xFF000000)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("Face authentication is successfully done. Taking you to the Dashboard.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: regular,
                    color: const Color(0xFF000000)),
              ),
              SizedBox(
                height: 62.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAuthFailureWidget(){
    return Column(
      children: [
        SizedBox(
          height: 10.h,
          width: double.infinity,
        ),
        SvgPicture.asset(
            "assets/svg/failure_message_icon.svg",fit: BoxFit.fill,
          height: 80.h,
          width: 80.w,
        ),
        SizedBox(
          height: 15.h,
        ),
        Text("No Biometric Match Found!",
          style: TextStyle(
              fontSize: 22,
              fontWeight: semiBold,
              color: const Color(0xFF000000)),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text("Please try placing your fingers one more time or clean the scanner.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontWeight: regular,
              color: const Color(0xFF000000)),
        ),
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: (){},
          child: Container(
            height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
            // width: 318.w,
            decoration: BoxDecoration(
              color: appWhite,
              border: Border.all(
                width: 1.w,
                color: appBackButtonBorder,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                "RETRY",
                style: widget.isMobile && !isMobileSize
                    ? AppTextStyle.tabletPortraitBackButtonText
                    : AppTextStyle.mobileBackButtonText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  showCustomAlert(List<Uint8List?> temp) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SingleChildScrollView(
        child: AlertDialog(
          content: SizedBox(
            height: (isMobileSize) ? 410.h : 610.h,
            width: 760.w,
            child: Column(
              children: [
                const SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 28,
                    ),
                    Text(
                      "$chosenValue capture successful",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 28, fontWeight: bold, color: blackShade1),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: blackShade1,
                          weight: 25,
                          size: 28,
                        )),
                  ],
                ),
                Divider(
                  height: 66,
                  thickness: 1,
                  color: secondaryColors.elementAt(22),
                ),
                Row(
                  mainAxisAlignment: (biometricAttributeData!.title == "Iris")
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    (biometricAttributeData!.title == "Iris" &&
                        biometricAttributeData!.exceptions.contains(true))
                        ? ((biometricAttributeData!.exceptions.first == true)
                        ? SvgPicture.asset(
                      "assets/svg/Left Eye Exception.svg",
                      height: (isMobileSize) ? 130.h : 260.h,
                    )
                        : const SizedBox())
                        : const SizedBox(),
                    ...temp.map(
                          (e) => Image.memory(
                        e!,
                        height: (isMobileSize) ? 130.h : 260.h,
                      ),
                    ),
                    (biometricAttributeData!.title == "Iris" &&
                        biometricAttributeData!.exceptions.contains(true))
                        ? ((biometricAttributeData!.exceptions.first == true)
                        ? const SizedBox()
                        : Transform.flip(
                      flipX: true,
                      child: SvgPicture.asset(
                        "assets/svg/Left Eye Exception.svg",
                        height: (isMobileSize) ? 130.h : 260.h,
                      ),
                    ))
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    setInitialState();
    biometricCaptureControlProvider =
        Provider.of<BiometricCaptureControlProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Login using",
                style: widget.isMobile
                    ? isMobileSize
                        ? AppTextStyle.mobileTextfieldHeader
                        : AppTextStyle.tabletPortraitTextfieldHeader
                    : AppTextStyle.mobileTextfieldHeader,
              ),
              const Text(
                ' *',
                style: TextStyle(color: mandatoryField),
              ),
            ],
          ),
          SizedBox(
            height: 11.h,
          ),
          Container(
            height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.h,
                color: appGreyShade,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: DropdownButton<String>(
              focusColor: Colors.white,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: chosenValue,
              icon: const Icon(Icons.keyboard_arrow_down,color: appGreyShade),
              style: TextStyle(
                fontSize: widget.isMobile && !isMobileSize ? 22 : 14,
                color: appBlack,
              ),
              iconEnabledColor: Colors.black,
              items: <String>['Password', 'Finger print', 'Iris', 'Face']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                        fontSize: widget.isMobile && !isMobileSize ? 22 : 14,
                        color: appBlack,
                      )),
                );
              }).toList(),
              hint: Text(
                "Select login method",
                style: TextStyle(
                  fontSize: widget.isMobile && !isMobileSize ? 22 : 14,
                  color: appBlack,
                ),
              ),
              onChanged: (v) {
                setState(() {
                  chosenValue = v!;
                if(v.contains("Iris")){
                  biometricAttributeData!.title = "Iris";
                  context.read<BiometricCaptureControlProvider>().biometricAttribute = "Iris";
                  biometricAttributeData =
                      context.read<BiometricCaptureControlProvider>().iris;
                }else if(v.contains("Finger print")){
                  biometricAttributeData!.title = "LeftHand";
                  context.read<BiometricCaptureControlProvider>().biometricAttribute = "LeftHand";
                  biometricAttributeData =
                      context.read<BiometricCaptureControlProvider>().leftHand;
                }else{
                  biometricAttributeData!.title = "Face";
                  context.read<BiometricCaptureControlProvider>().biometricAttribute = "Face";
                  biometricAttributeData =
                      context.read<BiometricCaptureControlProvider>().face;
                }
                });
              },
            ),
          ),

          (chosenValue == "Password")
              ? Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Text(
                    "Password",
                    style: widget.isMobile
                        ? isMobileSize
                            ? AppTextStyle.mobileTextfieldHeader
                            : AppTextStyle.tabletPortraitTextfieldHeader
                        : AppTextStyle.mobileTextfieldHeader,
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: mandatoryField),
                  ),
                ],
              ),
              SizedBox(
                height: 11.h,
              ),
              Container(
                height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.h,
                    color: appGreyShade,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: TextField(
                  obscureText: true,
                  onChanged: (v) {
                    widget.onChanged(v);
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_password,
                    hintStyle: widget.isMobile && !isMobileSize
                        ? AppTextStyle.tabletPortraitTextfieldHintText
                        : AppTextStyle.mobileTextfieldHintText,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: widget.isMobile && !isMobileSize ? 22 : 14,
                    color: appBlack,
                  ),
                ),
              )
            ],
          ): const SizedBox.shrink(),
          SizedBox(
            height: 15.h,
          ),

          SizedBox(
            height: 10.h,
          ),
          (chosenValue != "Password")
              ? authenticateButton()
              : InkWell(
                  onTap: !widget.isDisabled ? widget.onTapLogin : null,
                  child: Container(
                    height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
                    decoration: BoxDecoration(
                      color:
                          !widget.isDisabled ? appSolidPrimary : buttonDisabled,
                      border: Border.all(
                        width: 1.w,
                        color:
                            !widget.isDisabled ? appBlueShade1 : buttonDisabled,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: widget.isLoggingIn
                          ? const CircularProgressIndicator(
                              color: appWhite,
                            )
                          : Text(
                              AppLocalizations.of(context)!.login_button,
                              style: widget.isMobile && !isMobileSize
                                  ? AppTextStyle.tabletPortraitButtonText
                                  : AppTextStyle.mobileButtonText,
                            ),
                    ),
                  ),
                ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: widget.onTapBack,
            child: Container(
              height: widget.isMobile && !isMobileSize ? 82.h : 52.h,
              // width: 318.w,
              decoration: BoxDecoration(
                color: appWhite,
                border: Border.all(
                  width: 1.w,
                  color: appBackButtonBorder,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.back_button,
                  style: widget.isMobile && !isMobileSize
                      ? AppTextStyle.tabletPortraitBackButtonText
                      : AppTextStyle.mobileBackButtonText,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          (chosenValue == "Password")
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
            onTap: () {},
            child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.forgot_password.toUpperCase(),
                    style: widget.isMobile && !isMobileSize
                        ? AppTextStyle.tabletPortraitForgotPasswordText
                        : AppTextStyle.mobileForgotPasswordText,
                  ),
            ),
          ),
                ],
              ): const SizedBox.shrink(),
        ],
      ),
    );
  }
}
