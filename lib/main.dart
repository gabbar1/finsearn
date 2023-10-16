import 'package:finsearn/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveNavBarPage(),
    );
  }
}



class ResponsiveNavBarPage extends StatelessWidget {
  ResponsiveNavBarPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: ColorContant().inactiveColor,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(isLargeScreen)
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: Image.asset("assets/logo.png",height: 100,width: 100,),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems())
              ],
            ),
          ),
          actions:  [
            if(!isLargeScreen)
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Image.asset("assets/logo.png",height: 100,width: 100,),
              ),
            if(isLargeScreen)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorContant().appBackGroundColor
                  ),
                  child: Center(child: Text("Login"),),
                ),
              ),
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: const Center(
          child: Text(
            "Body",
          ),
        ),
      ),
    );
  }

  Widget _drawer() => Drawer(

    child: ListView(
      children: _menuItems
          .map((item) => ListTile(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        title: Text(item),
      ))
          .toList(),
    ),
  );

  Widget _navBarItems() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _menuItems
        .map(
          (item) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 24.0, horizontal: 16),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    )
        .toList(),
  );
}

final List<String> _menuItems = <String>[
  'Home',
  'About',
  'Profile',

];

enum Menu { itemOne, itemTwo, itemThree }

