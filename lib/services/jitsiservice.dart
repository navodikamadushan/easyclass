import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

class JistiVideoConference {
  testconstructor(String roomName, String subject, String displayname, String useremail) {
    print("roomName:" + roomName);
    print("subject:" + subject);
    print("displayname:" + displayname);
    print("useremail:" + useremail);
  }

  joinMeeting(String roomName, String subject, String displayname, String useremail) async {
    JitsiMeet.addListener(JitsiMeetingListener(onConferenceWillJoin: _onConferenceWillJoin, onConferenceJoined: _onConferenceJoined, onConferenceTerminated: _onConferenceTerminated, onError: _onError));

    String serverUrl = null;

    var isAudioOnly = true;
    var isAudioMuted = true;
    var isVideoMuted = true;

    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
      };
      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p
      //..iosAppBarRGBAColor = '#0080FF80' //iosAppBarRGBAColor.text
      var options = JitsiMeetingOptions()
        ..room = roomName
        ..serverURL = serverUrl
        ..subject = subject
        ..userDisplayName = displayname
        ..userEmail = useremail
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      dynamic result = await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: ({message}) {
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
