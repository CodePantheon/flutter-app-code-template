import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:drops_app/functions/localizations.dart';
import 'package:drops_app/pages/my_account/my_account.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchKeywordController = TextEditingController();
  final _searchKeywordFocusNode = FocusNode();
  int currentIndex;
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    //_searchKeywordFocusNode.addListener(_onSearchBarFocusChange);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 130.0,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo.jpg',
                    height: 40.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      setState(() => currentIndex = 1);
                    },
                  ),
                ],
              ),
            ),
            _buildNameField(context),
          ],
        ),
        titleSpacing: 0.0,
        actions: <Widget>[],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: WillPopScope(
        child: navBarPages(),
        onWillPop: () async {
          if (onWillPop()) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  Widget navBarPages(){
    switch(currentIndex){
      case 0:
        return HomeMain();
      case 1:
        return MyAccount();
      case 2:
        return MyAccount();
    }

    return HomeMain();
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BubbleBottomBar(
      backgroundColor: Theme.of(context).appBarTheme.color,
      hasNotch: false,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: changePage,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      //border radius doesn't work when the notch is enabled.
      elevation: 8,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.home,
              color: Theme.of(context).textTheme.headline6.color,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              AppLocalizations.of(context).translate('homePage', 'home'),
              style: TextStyle(fontSize: 13.0),
            )),
        BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).textTheme.headline6.color,
            ),
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              AppLocalizations.of(context).translate('homePage', 'cart'),
              style: TextStyle(fontSize: 13.0),
            )),
        BubbleBottomBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              FontAwesomeIcons.user,
              color: Theme.of(context).textTheme.headline6.color,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.user,
              color: Theme.of(context).primaryColor,
              size: 17.0,
            ),
            title: Text(
              AppLocalizations.of(context).translate('homePage', 'account'),
              style: TextStyle(fontSize: 13.0),
            ))
      ],
    );
  }

  Widget _buildNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 45.0,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: Icon(Icons.search),
          ),
          controller: _searchKeywordController,
          focusNode: _searchKeywordFocusNode,
        ),
      ),
    );
  }
}
