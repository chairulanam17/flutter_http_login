import 'package:flutter/material.dart';
import 'package:flutter_http_login/api/api_service.dart';
import 'package:flutter_http_login/model/login_model.dart';
import 'package:flutter_http_login/progressHUD.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => requestModel.siswa_username = input,
                          validator: (input) => !input.contains("@")
                              ? "Email Id should be Valid"
                              : null,
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => requestModel.siswa_password = input,
                          validator: (input) => input.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateandSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });

                              APIService apiService = new APIService();
                              apiService.login(requestModel).then((value) {
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                if (value.token.isNotEmpty) {
                                  final snackbar = SnackBar(
                                    content: Text("Login Berhasil"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                }
                                else {
                                  final snackbar = SnackBar(
                                    content: Text(value.error),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                }
                              });
                              print(requestModel.toJson());
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool validateandSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
