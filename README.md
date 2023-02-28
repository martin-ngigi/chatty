# chatty

A new Flutter project.

## Requirements:
- xamp sever - for MYSQL DB  and Php
- laravel - for API
- ngrok - to make our local laravel url public

- [Youtube link part 1](https://www.youtube.com/watch?v=4lmfvNgLlmE&t=360s&ab_channel=dbestech)
- [Youtube link part 2](https://www.youtube.com/watch?v=RFAfKO51jo8&ab_channel=dbestech)
- [Documentation part 1](https://www.dbestech.com/tutorials/flutter-firebase-chatting-app)
- 
- [Documentation part 2](https://www.dbestech.com/tutorials/flutter-video-chat-app)


## Getting Started
- To get all dependencies, run the following:
```
flutter pub get
```
- Run web app:
```
flutter run -d chrome
```

# SHA-1 Generation for android Method 1 (NB: MOST RECOMMENDED WAY)
1. Right click on 'gradlew' and go to 'Open in Terminal' This file is found under {{YOUR PROJECT}}/android/gradlew
1.1 Or Change directory to "android" i.e. cd android
2. Type in the following command.
```
gradlew signingReport
```
- or If did not work first try second command(on windows):
```
./gradlew signingReport
```

# SHA-1 Generation for android Method 2 ((NB: NOT RECOMMENDED))
1. For viewing the SHA-1 key from the keystore file that is in flutter project directory:
```
 keytool -list -v -keystore C:\Users\Administrator\AndroidStudioProjects\chatty\debug.keystore -alias androiddebugkey -storepass android -keypass android
```
2.1 But if there is no keystore file, SHA-1 can be created using following way:
```
keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000
```
2.2 For viewing the SHA-1 key from the keystore file that we created
```
  keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
```

# Obtaining package name in iOS:
- In iOS the package name is the bundle identifier in Info.plist. which is found in Runner.xcodeproj/project.pbxproj
```
PRODUCT_BUNDLE_IDENTIFIER = com.example.chatty;
```

## Local firebase configuration(This will register our applications to firebase and automatically add json files ;-)
- Add firebase .exe
- Add C:\Users\<username>\AppData\Local\Pub\Cache\bin to Environment Path.
- Executed command:
```
dart pub global activate flutterfire_cli
```
- login to firebase:
```
firebase login
```
- configure flutter 
```
flutterfire configure
```
- or
```
flutterfire.bat configure
```
### Sample screenshot for fireabse configration
- [fireabse configration](/assets/images/flutter_configure.png)

## enable Firebase In-App Messaging API
- [Firebase In-App Messaging API](https://console.cloud.google.com/marketplace/product/google/firebaseinappmessaging.googleapis.com)
- Project URL -> https://console.developers.google.com/apis/api/firebaseinappmessaging.googleapis.com/overview?project=453459214094
- Inside project directory, run following command to clean and get:
```
flutter clean
flutter pub get
```

## Web login
- flutter doc -> https://pub.dev/packages/google_sign_in_web
- to run web app :
```
flutter run -d chrome --web-hostname localhost --web-port 7357
```

## Agora
- [Dashboard](https://dashboard.agora.io/)
- [APPID](https://console.agora.io/projects)
