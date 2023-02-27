//stless
import 'package:chatty/common/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: Obx(()=> SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: 10.h,
                  left: 30.h,
                  right: 30.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        controller.state.callTime.value,
                        style: TextStyle(
                          color: AppColors.primaryElementText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Container(
                        width: 100.h,
                        height: 100.h,
                        margin: EdgeInsets.only(top: 150.h),
                        child: Image.network(
                          controller.state.to_avatar.value
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          controller.state.to_name.value,
                          style: TextStyle(
                            color: AppColors.primaryElementText,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
              ),
              Positioned(
                bottom: 80.h,
                  left: 30.h,
                  right: 30.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //microphone section
                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(15.w),
                              width: 60.h,
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30.w)),
                                color: controller.state.openMicrophone.value?
                                    AppColors.primaryElementText:
                                    AppColors.primaryText
                              ),
                              child: controller.state.openMicrophone.value?
                              Image.asset(
                                  "assets/icons/a_microphone.png"
                              ): Image.asset(
                                  "assets/icons/b_microphone.png"
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Microphone",
                              style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                      //phone section
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              /**
                               * User already joined = true so leaveChannel
                               * User left  = true so joinChannel()
                               */
                              controller.state.isJoined.value
                                  ? controller.leaveChannel
                                  : controller.joinChannel;
                            },
                            child: Container(
                              width: 60.h,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30.w)),
                                  color: controller.state.isJoined.value?
                                  AppColors.primary_bg:
                                  AppColors.primaryElementStatus
                              ),
                              child: controller.state.isJoined.value?
                              Image.asset(
                                  "assets/icons/call.png"
                              ): Image.asset(
                                  "assets/icons/a_call.png"
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              controller.state.isJoined.value?"Disconnect": "Connect",
                              style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                      // speaker section
                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 60.h,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30.w)),
                                  color: controller.state.enableSpeaker.value?
                                  AppColors.primaryElementText:
                                  AppColors.primaryText
                              ),
                              child: controller.state.enableSpeaker.value?
                              Image.asset(
                                  "assets/icons/a_volume.png"
                              ): Image.asset(
                                  "assets/icons/b_volume.png"
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Speaker",
                              style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      )),
    );
  }
}
