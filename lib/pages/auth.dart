import 'package:firstapp/models/auth.dart';
import 'package:firstapp/scoped-models/main.dart';
import 'package:firstapp/widgets/ui_elements/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;

  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, -1.5), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ईमेल',
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ) {
          return 'अवैध ईमेल';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'पासवर्ड',
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
      ),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'अवैध पासवर्ड';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return FadeTransition(
        opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        child: SlideTransition(
            position: _slideAnimation,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'पासवर्ड की पुष्टि कीजिये',
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
              ),
              obscureText: true,
              validator: (String value) {
                if (value != _passwordTextController.text &&
                    _authMode == AuthMode.Signup) {
                  return 'पासवर्ड नही मिल रहा';
                }
                return null;
              },
            )));
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('नियम और शर्तों को स्वीकार करें'),
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);
    if (successInformation['success']) {
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('- त्रुटि हुई'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('ठीक'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('लॉग इन करें'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: _buildBackgroundImage(),
            ),
            padding: EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                    width: targetWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildEmailTextField(),
                          SizedBox(
                            height: 11.0,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(
                            height: 10,
                          ),
                          _buildPasswordConfirmTextField(),
                          _buildAcceptSwitch(),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            child: Text(
                                'स्विच करें ${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'}'),
                            onPressed: () {
                              if (_authMode == AuthMode.Login) {
                                setState(() {
                                  _authMode = AuthMode.Signup;
                                });
                                _controller.forward();
                              } else {
                                setState(() {
                                  _authMode = AuthMode.Login;
                                });
                                _controller.reverse();
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ScopedModelDescendant<MainModel>(
                            builder: (BuildContext conntext, Widget child,
                                MainModel model) {
                              return model.isLoading
                                  ? Container(
                                      child: AdaptiveProgressIndicator(),
                                      padding: EdgeInsets.all(3),
                                    )
                                  : RaisedButton(
                                      textColor: Colors.white,
                                      child: Text(
                                          '${_authMode == AuthMode.Login ? 'Login' : 'Sign Up'}'),
                                      onPressed: () =>
                                          _submitForm(model.authenticate),
                                    );
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
