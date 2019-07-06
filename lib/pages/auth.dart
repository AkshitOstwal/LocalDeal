import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'E-Mail',filled: true,fillColor: Colors.white.withOpacity(0.7),),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _emailValue = value;
                    });
                  },
                ),
                SizedBox(height: 11.0,),
                TextField(
                  decoration: InputDecoration(labelText: 'Password',filled: true,fillColor: Colors.white.withOpacity(0.7),),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
                  },
                ),
                SwitchListTile(
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  title: Text('Accept Terms and Condition'),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("LOGIN"),
                    onPressed: () {
                      print(_emailValue);
                      print(_passwordValue);
                      Navigator.pushReplacementNamed(context, '/products');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
