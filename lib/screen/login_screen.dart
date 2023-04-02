import 'package:flutterproject/main.dart';
import 'package:flutterproject/screen/create_account_screen.dart';
import 'package:flutterproject/screen/show_item.dart';
import 'package:flutterproject/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/main.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Admin Login(Teacher)',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  )
                ),
            ],
           ), 
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              // call service.login
              // check result and open new screen
              onPressed: () {
                _loginUser(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 92, 252)),
              child: const Text("Login"),
            ),
            const SizedBox(
              height: 20,
            ),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => CreateAccountScreen()));
            //     },
            // child: const Text("No account? create new >>")),

            const SizedBox(
              height: 20,
            ),
            
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Score Student',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 97, 19),
                  )),
            ],
           ),const SizedBox(
              height: 20,
            ),ElevatedButton(
              // call service.login
              // check result and open new screen
              onPressed: () {
                _showScore(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 81, 13)),
              child: const Text("Show Score"),
            ),

          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) async {
    final message = await AuthService().login(
        email: _emailController.text, password: _passwordController.text);
    if (message!.contains("Success")) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(
                title: 'Flutter Project Score Thidarat',
              )));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error")));
    }
  }
}

void _showScore(BuildContext context) async {
  Navigator.push(
        context, MaterialPageRoute(builder: (context) => 
        const ShowScoreScreen(title:'Show Score',)));;
}
