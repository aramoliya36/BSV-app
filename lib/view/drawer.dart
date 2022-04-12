import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        semanticLabel: "AppDrawer",
        elevation: 1,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/Icon/back_button.svg"),
                  )),
                  child: Text("Header"),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                  children: List.generate(
                5,
                (index) => ListTile(
                  title: Text("Home"),
                  onTap: () {},
                ),
              )),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: 20,
                width: 20,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
