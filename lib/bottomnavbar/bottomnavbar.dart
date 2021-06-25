import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kullanicigirisitest/screens/SepetlerSayfasi/basketpage.dart';
import 'package:kullanicigirisitest/screens/KategorilerSayfasi/categorypage.dart';
import 'package:kullanicigirisitest/screens/digerpage.dart';
import 'package:kullanicigirisitest/screens/KampanyalarSayfasi/kampanyapage.dart';

class BottomNavBar extends StatefulWidget {
  final int i;
  const BottomNavBar({Key key, this.i}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        //backgroundColor: Colors.brown[300],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Sipariş',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Sepetim'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot_rounded),
            title: Text('Kampanyalar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_weight),
            title: Text('Diğer'),
          ),
        ],
      ),
      tabBuilder: (context, i) {
        switch (i) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: denemeCategory(),
              );
            });

          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: denemeBasket2(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: denemeKampanya(),
              );
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: DigerPage(),
              );
            });

          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: denemeCategory(),
              );
            });
        }
      },
    );
  }
}
