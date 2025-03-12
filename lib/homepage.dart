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
