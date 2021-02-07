import 'dart:io';

import 'package:drops_app/common/helper_methods.dart';
import 'package:drops_app/functions/localizations.dart';
import 'package:drops_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'login.dart';
import 'login_controller.dart';
import 'login_form_validator.dart';
import 'models/user_info.dart';
import 'widgets/animated_button.dart';
import 'widgets/widget_helper.dart';

class SignupPage extends StatefulWidget {
  final Widget nextPage;

  const SignupPage({this.nextPage});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  AnimationController _submitController;

  DateTime _currentBackPressTime;

  @override
  void initState() {
    _submitController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    super.initState();
  }

  @override
  void dispose() {
    _submitController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      body: WillPopScope(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width - 40.0,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.5,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  child: _buildLoginForm(context, myLocale),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          if (onWillPop()) {
            exit(0);
          } else {
            return false;
          }
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, Locale myLocale) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildLogo(),
          SizedBox(height: 20.0),
          _buildNameField(context),
          SizedBox(height: 20.0),
          _buildEmailField(context),
          SizedBox(height: 20.0),
          _buildPhoneNumberField(context),
          SizedBox(height: 20.0),
          _buildPasswordField(context),
          SizedBox(height: 20.0),
          _buildConfirmPasswordField(context),
          SizedBox(height: 30.0),
          _buildCreateAccountButton(context, myLocale),
          SizedBox(height: 15.0),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/logo.jpg',
      height: 80.0,
    );
  }

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: "Full Name",
        prefixIcon: Icon(Icons.person),
      ),
      controller: _nameController,
      focusNode: _nameFocusNode,
      validator: LoginFormValidator.nameValidator,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: AppLocalizations.of(context).translate(
          'loginPage',
          'emailString',
        ),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      focusNode: _emailFocusNode,
      validator: LoginFormValidator.emailValidator,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
      },
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: "Mobile",
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      controller: _phoneNumberController,
      focusNode: _phoneNumberFocusNode,
      validator: LoginFormValidator.mobileNumberValidator,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: AppLocalizations.of(context).translate(
          'loginPage',
          'passwordString',
        ),
        prefixIcon: Icon(Icons.vpn_key),
      ),
      obscureText: true,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      validator: LoginFormValidator.passwordValidator,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.only(
          left: 14.0,
          bottom: 8.0,
          top: 8.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: AppLocalizations.of(context).translate(
          'signupPage',
          'repeatPasswordString',
        ),
        prefixIcon: Icon(Icons.verified_user),
      ),
      obscureText: true,
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      validator: (value) => value != _passwordController.text
          ? "Password does not match!"
          : null,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context, Locale myLocale) {
    return AnimatedButton(
      color: Theme.of(context).primaryColor,
      loadingColor: Theme.of(context).primaryColor,
      controller: _submitController,
      text: AppLocalizations.of(context).translate(
        'loginPage',
        'createAccountString',
      ),
      onPressed: _submit,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: () => pushPage(context, LoginPage()),
      child: Text(
        AppLocalizations.of(context).translate(
          'loginPage',
          'loginString',
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6.color,
          fontFamily: 'Jost',
          fontSize: 16.0,
          letterSpacing: 0.7,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<bool> _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (!_formKey.currentState.validate()) {
      return false;
    }

    _formKey.currentState.save();
    _submitController.forward();

    String error = await signup();

    _submitController.reverse();

    if (error?.isNotEmpty ?? false) {
      showErrorToast(context, error);
      return false;
    } else {
      onLoginSuccess();
      return true;
    }
  }

  Future<String> signup() async {
    var userInfo = UserInfo(
      name: _nameController.text,
      email: _emailController.text,
      phoneNo: _emailController.text,
      password: _passwordController.text,
    );

    final controller = Provider.of<LoginController>(context, listen: false);
    return controller.signup(userInfo: userInfo);
  }

  void onLoginSuccess() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: HomePage(),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate(
          'homePage',
          'exitToastString',
        ),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    } else {
      return true;
    }
  }
}
