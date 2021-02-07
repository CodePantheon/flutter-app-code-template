import 'package:drops_app/functions/localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
import 'login_form_validator.dart';
import 'widgets/animated_button.dart';
import 'widgets/widget_helper.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  AnimationController _submitController;

  @override
  void initState() {
    _submitController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                _buildLogo(),
                SizedBox(height: 25.0),
                Container(
                  width: width - 40.0,
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    right: 10.0,
                    left: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  child: _buildForm(width, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _buildForm(double width, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildEmailField(width, context),
          SizedBox(height: 30.0),
          _buildResetPasswordButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(double width, BuildContext context) {
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
          'forgotPasswordPage',
          'registeredEmailString',
        ),
        prefixIcon: Icon(Icons.email),
      ),
      controller: _emailController,
      validator: LoginFormValidator.emailValidator,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    Theme.of(context).copyWith();

    return AnimatedButton(
      color: Theme.of(context).primaryColor,
      loadingColor: Theme.of(context).primaryColor,
      controller: _submitController,
      text: AppLocalizations.of(context).translate(
        'forgotPasswordPage',
        'resetPasswordString',
      ),
      onPressed: _submit,
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/logo.jpg',
      height: 80.0,
    );
  }

  Future<bool> _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (!_formKey.currentState.validate()) {
      return false;
    }

    _formKey.currentState.save();
    _submitController.forward();

    String error = await _requestPasswordReset();

    _submitController.reverse();

    if (error?.isNotEmpty ?? true) {
      showErrorToast(context, error);
      return false;
    } else {
      showSuccessToast(context,
          "Request to reset password received. Check your inbox for the reset link.");
      return true;
    }
  }

  Future<String> _requestPasswordReset() async {
    final controller = Provider.of<LoginController>(context, listen: false);
    return controller.forgotPassword(email: _emailController.text);
  }
}
