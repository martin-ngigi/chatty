import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/pages/message/voicecall/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/apis/chat.dart';
import '../../../common/entities/chat.dart';
import '../../../common/values/server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class VoiceCallController extends GetxController{
  VoiceCallController();

  final state = VoiceCallState(); //get the variable
  final player = AudioPlayer();
  String appId = APPID;
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.profile.token;
  late final RtcEngine engine;
  ChannelProfileType channelProfileType = ChannelProfileType.channelProfileCommunication;

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get data from chat controller
    var data = Get.parameters;
    state.to_name.value = data["to_name"]??""; //if empty, place ""
    state.to_avatar.value = data["to_avatar"]??""; //if empty, place ""
    state.call_role.value = data["call_role"]??"";

     print("-----------YOUR NAME ${state.to_name.value }");

     initEngine();
  }
  
  Future<void> initEngine() async{
     ////////////////////////NOT EXISITING IN SPECIFIED DIRECTORY
     await player.setAsset("assets/ringtones/ringtone1.mp3");

     engine = createAgoraRtcEngine();
     await engine.initialize(RtcEngineContext(
       appId: appId
     ));

     //register events
    engine.registerEventHandler(RtcEngineEventHandler(
      /**
       * error codes
       */
        onError: (ErrorCodeType err, String msg){
        print('.....[onError] err: $err, , msg: $msg');
      },
        /**
         * establish connection
         */
      onJoinChannelSuccess: (RtcConnection connection, int elapsed){
        print('......onConnection ${connection.toJson()}');
        state.isJoined.value = true;
      },
        /**
         * after remote user has joined, stop playing the audio
         */
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
        print('......onUserJoined , remote user joined ${connection.toJson()}');
        await player.pause();
      },
        /**
         * user left call
         */
      onLeaveChannel: (RtcConnection connection, RtcStats stats){
        print("....... user left the room");
        state.isJoined.value=false;
      },

        /**
         * print call duration
         */
        onRtcStats: (RtcConnection connection, RtcStats stats){
        print("Time ...");
        print("Duration is : ${stats.duration}");
      }
    ));

    //enable audio
    await engine.enableAudio();
    //set user role as broadcaster ... ie one who is calling,
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming
    );

    //join the channel
     await joinChannel();

     /// the host makes a call, play a song
     if(state.call_role == "anchor"){
       ///send notification to receiver to answer the call
       await player.play();
     }
  }

  Future<String> getToken() async {
     /// if the person is host or caller
     if(state.call_role=="anchor"){
       /// get caller token and encode it ... i.e. Me
       /// $profile_token is the caller token.
       /// $to_token is the receiver token.
       state.channelId.value = md5.convert(utf8.encode("${profile_token}_${state.to_token.value}")).toString();
     }
     else{
       /// get receiver token and encode it
       /// $to_token is the caller token.
       /// $profile_token is the receiver token.
       state.channelId.value = md5.convert(utf8.encode("${state.to_token.value}_${profile_token}")).toString();
     }

     CallTokenRequestEntity callTokenRequestEntity = CallTokenRequestEntity();
     callTokenRequestEntity.channel_name = state.channelId.value;
     print("---------> [VoiceController] channel id: ${state.channelId.value}");
     var res = await ChatAPI.call_token(params: callTokenRequestEntity );
     if(res.code == 0){
       ///success
       return res.data!;
     }
     return "";
  }

  //join channel
  Future<void> joinChannel() async {
     //request device microphone
     await Permission.microphone.request();
     // show loading icon
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    String token =  await getToken(); ///this token comes from our server.
    if(token.isEmpty){
      /// end call
      EasyLoading.dismiss();
      Get.back();
      return; /// dont execute beyond this point.
    }

     //connect to the user
     /**
      * token and channelId should be generated dynamically and should be different for each user.
      */
    await engine.joinChannel(
      /**
       * NB: token will expire after 24 hours
       * Generated from "Temp token for audio/video call"
       */
        token: token,
        channelId: state.channelId.value,
        uid: 0,
        options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster
        )
    );

     EasyLoading.dismiss();
  }

  //leave the conversation
  Future<void> leaveChannel() async {
     EasyLoading.show(
       indicator: CircularProgressIndicator(),
       maskType: EasyLoadingMaskType.clear,
       dismissOnTap: true
     );

     await player.pause();
     state.isJoined.value = false;
     EasyLoading.dismiss();
     //return to previous page which is chat page
     Get.back();
  }


  Future<void> _dispose() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

}