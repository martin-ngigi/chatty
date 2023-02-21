# chatty

A new Flutter project.

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
# SHA-1 Generation for android
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