import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:step_counter/data/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  final AuthService authService;

  const AuthPage({Key? key, required this.authService}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthPage> {
  bool showLogin = true;

  final loginTextController = TextEditingController(text: "test@ukr.net");
  final passwordTextController = TextEditingController(text: "12345qweasd");

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  @override
  void dispose() {
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> auth() async {
      final _login = loginTextController.text;
      final _password = passwordTextController.text;

      if (_login.isEmpty || _password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter you Email/Password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }
      _isAuthProgress = true;

      final user = await widget.authService
          .signInWithEmailAndPassword(_login.trim(), _password.trim());

      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check you Email/Password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        loginTextController.clear();
        passwordTextController.clear();
      }

      _isAuthProgress = false;
    }

    Future<void> register() async {
      final login = loginTextController.text;
      final password = passwordTextController.text;

      if (login.isEmpty || password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter you Email/Password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return;
      }
      _isAuthProgress = true;

      final user = await widget.authService.signUpWithEmailAndPassword(
          login.toString().trim(), password.toString().trim());

      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check you Email/Password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        loginTextController.clear();
        passwordTextController.clear();
      }

      _isAuthProgress = false;
    }

    Widget button(String text) {
      return ElevatedButton(
        onPressed: (text == "LOGIN")
            ? (canStartAuth == true ? () => auth() : null)
            : (canStartAuth == true ? () => register() : null),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          backgroundColor:
              // MaterialStateProperty.all(Colors.black),
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          foregroundColor:
              MaterialStateProperty.all(Theme.of(context).cardColor),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 30, vertical: 0)),
        ),
        child: isAuthProgress == true
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white60,
                  strokeWidth: 2,
                ))
            : Text(text),
      );
    }

    Widget form(String label) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 110),
          InputTextFieldAuth(
            icon: const Icon(Icons.email),
            hint: "EMAIL",
            controller: loginTextController,
            obscure: false,
          ),
          const SizedBox(height: 20),
          InputTextFieldAuth(
            icon: const Icon(Icons.lock),
            hint: "PASSWORD",
            controller: passwordTextController,
            obscure: true,
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: button(label),
          ),
        ],
      );
    }

    Widget logo() {
      return Text(
        '''STEP
        COUNTER''',
        // textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).cardColor,
            fontSize: 50,
            fontWeight: FontWeight.w700),
      );
    }

    Widget bottomWave() {
      return Expanded(
          child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomWaveClipper(),
          child: Container(
            color: Theme.of(context).cardColor,
            height: 300,
          ),
        ),
      ));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFe6e6e6),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          (showLogin
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      form("LOGIN"),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: const Text('Not registered yet? Register!',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 130, 128, 128))),
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      form("REGISTER"),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: const Text(
                            'Already registered? Login!',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 130, 128, 128),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          const SizedBox(height: 50),
          logo(),
          bottomWave(),
        ],
      ),
    );
  }
}

class InputTextFieldAuth extends StatefulWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool obscure;

  const InputTextFieldAuth({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    required this.obscure,
  }) : super(key: key);

  @override
  State<InputTextFieldAuth> createState() => _InputTextFieldAuthState();
}

class _InputTextFieldAuthState extends State<InputTextFieldAuth> {
  bool _isHiddenPassword = true;
  @override
  void initState() {
    _isHiddenPassword = !widget.obscure;
    super.initState();
  }

  void toglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText:
          (widget.hint == 'PASSWORD') ? !_isHiddenPassword : widget.obscure,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xFF404040),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        suffix: (widget.hint == 'PASSWORD')
            ? InkWell(
                onTap: toglePasswordView,
                child: Icon(
                  _isHiddenPassword ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 174, 171, 171),
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        isCollapsed: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: IconTheme(
            data: const IconThemeData(
              color: Color.fromARGB(255, 174, 171, 171),
            ),
            child: widget.icon,
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 17,
          color: Color.fromARGB(255, 174, 171, 171),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: Theme.of(context).cardColor,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);

    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
