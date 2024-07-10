import 'package:flutter/material.dart';

import '../widget/google_sign_in/google_sign_in.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              print('object');
            }, child: Text('test')),
            GoogleSignInButton()
          ],
        ),
      ),
    );
  }
}
