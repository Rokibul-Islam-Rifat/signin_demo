# signin_demo

A new Flutter project for login
.

## Getting Started

For implementing Facebook login 
First you need to create a project
2. You need to install 3 packages in pubspec.yml
1. firebase auth
2. firebase core
3. flutter facebook auth
=> command Flutter pub get in terminal.

On the browser Tthen go to the flutter developer site in the browser and open the firebase console site with it,
first go to the firebase console and click on create project,
then give it a name, then click on the continue option,
select any option in Configure Google Analytics until it comes to Configure Google Analytics.
When the project is created, click on the flutter option, click on the Firebase CLI option and paste this code in the project's terminal and press enter

=> npm install -g firebase-tools

In firebase's Prepare your workspace, click on next

=> dart pub global activate flutterfire_cli
=>flutterfire configure --project=asfds-f151f

Copy these 2 options and paste them in the terminal
then again next
=>
Initialize Firebase and add plugins
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
Copy this to the project main. dart
void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const MyApp());
}
You have to paste it like this
then next
=>
After that, go to the project over video and build =>Authentication=>signin -Method =>Select Facebook
Now you have to go to the facebook developer site => Select my app => Create app => Give a name to app details => Use case from others => business => Click create again and then give password
=> Facebook login with Facebook Login for Business setup => 
QuickStart => Select Android => Step 1 next =>In your project, 

=>open your_app | Gradle Scripts | build.gradle (Project) and add the following repository to the buildscript { repositories {}} section to download the SDK from the Maven Central Repository:
mavenCentral() =>In your project, 
=>open your_app | Gradle Scripts | build.gradle (Module: app) and add the following compile statement to the dependencies{} section to compile the latest version of the SDK:
implementation 'com.facebook.android:facebook-android-sdk:latest.release'
=> next cilck => tell Us about Your Android Project
Package Name
Your package name uniquely identifies your Android app. We use this to let people download your app from Google Play if they don't have it installed. You can find this in your Android Manifest or your app's build.gradle file.
<com.example.myapp>
Default Activity Class Name
This is the fully qualified class name of the activity that handles deep linking such as com.example.app.DeepLinkingActivity. We use this when we deep link into your app from the Facebook app. You can also find this in your Android Manifest.
<com.example.myapp.MainActivity> CLICK NEXT =>
4. Add Your Development and Release Key Hashes
Mac OS
You will need the Key and Certificate Management Tool (keytool) from the Java Development Kit.
To generate a development key hash, open a terminal window and run the following command:

keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64 => 
paste it in project terminal and copy Key Hashes Paste it in Facebook Developer Key Hashes save continue => give next


=> Open your /app/res/values/strings.xml file.
Add string elements with the names facebook_app_id, fb_login_protocol_scheme and facebook_client_token, and set the values ​​to your App ID and Client Token. 
For example, if your app ID is 1234 and your client token is 56789 your code looks like the following:
<string name="facebook_app_id">1234</string>
<string name="fb_login_protocol_scheme">fb1234</string>
<string name="facebook_client_token">56789</string>


=> Open the /app/manifest/AndroidManifest.xml file.
Add meta-data elements to the application element for your app ID and client token:
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.example.signin_demo"
xmlns:tools="http://schemas.android/tools"
>
<application android:label="@string/app_name" ...>
 <meta-data
 android:name="flutterEmbedding"
 android:value="2" />
<=====After this line paste this =====>
 <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
 <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
Add an activity for Facebook, and an activity and intent filter for Chrome Custom Tabs inside your application element:
 <activity android:name="com.facebook.FacebookActivity"
 android:configChanges=
 "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
 android:label="@string/app_name" />
 <activity
 android:name="com.facebook.CustomTabActivity"
 android:exported="true">
 <intent-filter>
 <action android:name="android.intent.action.VIEW" />
 <category android:name="android.intent.category.DEFAULT" />
 <category android:name="android.intent.category.BROWSABLE" />
 <data android:scheme="@string/fb_login_protocol_scheme" />
 </intent-filter>
 </activity>
</application>

=> Add a uses-permission element to the manifest after the application element
<uses-permission android:name="android.permission.INTERNET"/>
Copy Code

=> To opt out of the Advertising ID Permission, add a uses-permission element to the manifest after the application element:
<uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
Copy Code

>facebook developer basic App ID copy that and add in firebase App ID
> facebook developer basic App secret copy that and add in firebase App secret and lastly save it 





now go to the Homepage.dart 
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isLogin = false;
  Map<String, dynamic> _userObj = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Facebook Login')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:
            _isLogin == true
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_userObj['name']?? 'No Name'),
                    Text(_userObj['email'] ?? 'No Email'),
                    TextButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            _isLogin = false;
                            _userObj = {};
                          });
                        });
                      },
                      child: Text('Logout'),
                    ),
                  ],
                )
                : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FacebookAuth.instance
                          .login(permissions: ['public_profile', 'email'])
                          .then((value) {
                            FacebookAuth.instance.getUserData().then((
                              userData,
                            ) {
                              setState(() {
                                _isLogin = true;
                                _userObj = userData;
                              });
                            });
                          });
                    },
                    child: Text("Facebook Login"),
                  ),
                ),
      ),
    );
  }
}

this is the video link for facebook login
[https://drive.google.com/drive/u/1/folders/1sxTREmfZV_w9WiEc4AoN64X7lLBpLCQU](https://drive.google.com/drive/u/1/folders/1sxTREmfZV_w9WiEc4AoN64X7lLBpLCQU)
