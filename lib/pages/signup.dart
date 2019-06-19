import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_commerss/pages/homepage.dart';
import '../db/users.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  userServices _userServices= userServices();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController =
      TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  String _email, _pasword, _gender;
  String _groupvalue = "male";
  bool _hidePass = true;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

   // preferences = await SharedPreferences.getInstance();
    FirebaseUser user = await firebaseAuth.currentUser().then((user){
        if(user != null){
          setState(() {
            isLogedin = true;
          });
        }
    });
//    if (isLogedin) {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => Homepage()));
//    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'image/beautiful-woman-fashion-fashion-model-1926769 (1).jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          //TODO:: make the logo show
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        //======== start name ========

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                onSaved: (String value) {
                                  _pasword = value;
                                },
                                controller: _nameTextController,
                                decoration: InputDecoration(
                                  hintText: "Full name",
                                  icon: Icon(Icons.person_outline),
                                  // de 3l4an a4el el 5at
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The Name field cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        // ========== Start code in email ========
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                onSaved: (String value) {
                                  _email = value;
                                },
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
                                  // de 3l4an a4el el 5at
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please make sure your email address is valid';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
// ========== Radio button

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: ListTile(
                                        title: Text(
                                          "Male",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailing: Radio(
                                            value: "male",
                                            groupValue: _groupvalue,
                                            onChanged: (e) => valueChange(e)))),
                                Expanded(
                                    child: ListTile(
                                        title: Text(
                                          "Female",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        trailing: Radio(
                                            value: "female",
                                            groupValue: _groupvalue,
                                            onChanged: (e) => valueChange(e)))),
                              ],
                            ),
                          ),
                        ),
                        // ============ Start code in  password =======
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  onSaved: (String value) {
                                    _pasword = value;
                                  },
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                                  controller: _passwordTextController,
                                  obscureText: _hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    // de 3l4an a4el el 5at
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
                                  setState(() {
                                    _hidePass= false;
                                  });
                                })
                              ),
                            ),
                          ),
                        ),

                        //====== start confirm password  ==========

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  onSaved: (String value) {
                                    _pasword = value;
                                  },
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                                  controller: _confirmpasswordTextController,
                                  obscureText: _hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Confirm password",
                                    icon: Icon(Icons.lock_outline),
                                    // de 3l4an a4el el 5at
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    } else if (_passwordTextController.text !=
                                        value) {
                                      return "the passwords don't match";
                                    }
                                    return null;
                                  },
                                ),
                                  trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
                                    setState(() {
                                      _hidePass= false;
                                    });
                                  })
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.red.shade700,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: ()
                                  async{
                                    validateForm();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Sign up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))))
                      ],
                    )),
              ),
            ),
          ),

          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  valueChange(e) {
    setState(() {
      if (e == "male") {
        _groupvalue = e;
        _gender = e;
      } else if (e == "female") {
        _groupvalue = e;
        _gender = e;
      }
    });
  }

  Future<void> validateForm() async{
    FormState formState = _formKey.currentState;
    if(formState.validate()){
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null){
        firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
            .then((user)=> {

            /*_userServices.createUser(
              user.uid.toString(),
              {
                "userName": user.displayName,
                "email": user.email,
                "userId": user.uid,
                "gender": _gender,
              }
            )*/
        _userServices.createUser(
            {
              "userName": _nameTextController.text,
              "email": _emailTextController.text,
              "userId": user.uid,
              "gender": _gender,
            }
        )

        }).catchError((err)=>{print(err.toString())});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    }
  }
}
