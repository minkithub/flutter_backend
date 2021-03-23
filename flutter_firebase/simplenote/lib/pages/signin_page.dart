import 'package:flutter/material.dart';
import 'package:simplenote/pages/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:simplenote/providers/auth_provider.dart';

class SigninPage extends StatefulWidget {
  static const String routeName = 'signin-page';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _fkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String _email, _passward;

  void _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    if (!_fkey.currentState.validate()) return;

    // _email, _password에 사용자 입력값 저장
    _fkey.currentState.save();

    print('email : $_email, password : $_passward');

    try {
      await context
          .read<AuthProvider>()
          .signIn(email: _email, password: _passward);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthProvider>().state;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Notes',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _fkey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email)),
                        validator: (String val) {
                          if (!val.trim().contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        onSaved: (val) => _email = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.security)),
                        validator: (String val) {
                          if (val.trim().length < 6) {
                            return 'Password must be at least 6 long';
                          }
                          return null;
                        },
                        onSaved: (val) => _passward = val,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      // loading중일때는 버튼이 disabled됨.
                      onPressed: authState.loading == true ? null : _submit,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: authState.loading == true
                          ? null
                          : () {
                              Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                            },
                      child: Text(
                        'No account? Sing Up!',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
