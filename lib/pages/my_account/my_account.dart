import 'package:drops_app/common/helper_methods.dart';
import 'package:drops_app/functions/localizations.dart';
import 'package:drops_app/pages/home/home_page.dart';
import 'package:drops_app/pages/login_signup/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'account_setting.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          width: width,
          height: 360.0,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/user_profile/background.jpg'),
                width: width,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 165.0,
                right: ((width / 2) - 50.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 110.0,
                      width: 110.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55.0),
                        border: Border.all(color: Colors.white, width: 5.0),
                      ),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(50.0),
                        child: Image(
                          image: AssetImage('assets/user_profile/user_3.jpg'),
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Sisir Pathy',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: InkWell(
                        child: Text(
                          AppLocalizations.of(context).translate(
                            'myAccountPage',
                            'editProfileString',
                          ),
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30.0, left: 70.0),
          child: Divider(height: 1.0),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: AccountSetting(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.cogs,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  AppLocalizations.of(context).translate(
                    'myAccountPage',
                    'accountSettingString',
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30.0, left: 70.0),
          child: Divider(height: 1.0),
        ),
        InkWell(
          onTap: () => logoutDialogue(width),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  AppLocalizations.of(context).translate(
                    'myAccountPage',
                    'logoutString',
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30.0, left: 70.0),
          child: Divider(height: 1.0),
        ),
      ],
    );
  }

  logoutDialogue(double width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate(
                        'myAccountPage',
                        'sureDialogueString',
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('myAccountPage', 'closeString'),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<LoginController>(context).logout();
                            pushPage(context, HomePage());
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('myAccountPage', 'logoutString'),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).appBarTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
