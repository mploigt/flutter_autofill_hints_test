import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  FocusNode _usernameFocus;
  FocusNode _passwordFocus;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    print(_usernameController.text);
    print(_passwordController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoggedIn(_usernameController.text, _passwordController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    TextFormField(
                      key: Key('username'),
                      decoration: InputDecoration(
                        hintText: 'username',
                      ),
                      enableInteractiveSelection: true,
                      textInputAction: TextInputAction.next,
                      focusNode: _usernameFocus,
                      controller: _usernameController,
                      onFieldSubmitted: (term) {
                        _passwordFocus.requestFocus();
                      },
                      autofillHints: const <String>[AutofillHints.username],
                    ),
                    TextFormField(
                      key: Key('password'),
                      decoration: InputDecoration(
                        hintText: 'password',
                      ),
                      enableInteractiveSelection: true,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocus,
                      controller: _passwordController,
                      autofillHints: const <String>[AutofillHints.password],
                      onFieldSubmitted: (value) {
                        _submit(context);
                      },
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () => _submit(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoggedIn extends StatelessWidget {
  const LoggedIn(this.username, this.password);

  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Logged In'),
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Logged In as "$username" with password "$password"',
                  softWrap: true,
                  maxLines: 5,
                ))));
  }
}
