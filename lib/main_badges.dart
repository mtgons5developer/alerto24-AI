import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const HomeScreen(),
    );
  }
}

ThemeData _buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
      primaryIconTheme: base.iconTheme.copyWith(color: Colors.black));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  bool showElevatedButtonBadge = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: AppBar(
          leading: Badge(
            position: BadgePosition.topEnd(top: 10, end: 10),
            badgeContent: null,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
          title: const Text('Badge Demo', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            _shoppingCartBadge(),
          ],
          bottom: _tabBar(),
        ),
        body: Column(
          children: <Widget>[
            _addRemoveCartButtons(),
            _textBadge(),
            _directionalBadge(),
            _elevatedButtonBadge(),
            _chipWithZeroPadding(),
            expandedBadge(),
            _badgeWithZeroPadding(),
            _badgesWithBorder(),
            _listView(),
          ],
        ),
      ),
    );
  }

  Widget expandedBadge() {
    return const Expanded(
      child: Center(
        child: Badge(
          badgeContent: Text('10'),
          child: Icon(Icons.person, size: 30),
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        _counter.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }

  PreferredSizeWidget _tabBar() {
    return TabBar(tabs: [
      const Tab(
        icon: Badge(
          badgeColor: Colors.blue,
          badgeContent: Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(Icons.account_balance_wallet, color: Colors.grey),
        ),
      ),
      Tab(
        icon: Badge(
          shape: BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          position: BadgePosition.topEnd(top: -12, end: -20),
          padding: const EdgeInsets.all(2),
          badgeContent: const Text(
            'NEW',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          child: Text(
            'MUSIC',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    ]);
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          label: 'Events',
          icon: Icon(Icons.event),
        ),
        const BottomNavigationBarItem(
          label: 'Messages',
          icon: Icon(Icons.message),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Badge(
            shape: BadgeShape.circle,
            position: BadgePosition.center(),
            borderRadius: BorderRadius.circular(100),
            child: const Icon(Icons.settings),
            badgeContent: Container(
              height: 5,
              width: 5,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addRemoveCartButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Add to cart')),
          ElevatedButton.icon(
              onPressed: () {
                if (_counter > 0) {
                  setState(() {
                    _counter--;
                  });
                }
              },
              icon: const Icon(Icons.remove),
              label: const Text('Remove from cart')),
        ],
      ),
    );
  }

  Widget _textBadge() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Badge(
        padding: const EdgeInsets.all(6),
        gradient: const LinearGradient(colors: [
          Colors.black,
          Colors.red,
        ]),
        badgeContent: const Text(
          '!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: BadgePosition.topStart(top: -15),
        child: const Text('This is a text'),
      ),
    );
  }

  Widget _elevatedButtonBadge() {
    return Badge(
      showBadge: showElevatedButtonBadge,
      padding: const EdgeInsets.all(8),
      badgeColor: Colors.deepPurple,
      badgeContent: const Text(
        '!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            showElevatedButtonBadge = !showElevatedButtonBadge;
          });
        },
        child: const Text('Raised Button'),
      ),
    );
  }

  Widget _chipWithZeroPadding() {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Chip with zero padding:'),
      Chip(
        label: Text('Hello'),
        padding: EdgeInsets.all(0),
      ),
    ]);
  }

  Widget _badgeWithZeroPadding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Badges:'),
        for (int i = 0; i < 5; i++)
          _getExampleBadge(padding: (i * 2).toDouble())
      ],
    );
  }

  Widget _getExampleBadge({double? padding}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Badge(
        badgeColor: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.all(padding ?? 4),
        shape: BadgeShape.square,
        badgeContent: const Text(
          'Hello',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _badgesWithBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Badges with borders:'),
          Badge(
            position: BadgePosition.topEnd(top: 0, end: 2),
            elevation: 0,
            shape: BadgeShape.circle,
            badgeColor: Colors.red,
            borderSide: const BorderSide(color: Colors.black),
            child: const Icon(
              Icons.person,
              size: 30,
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: -5, end: -5),
            shape: BadgeShape.square,
            badgeColor: Colors.blue,
            badgeContent: const SizedBox(
              height: 5,
              width: 5,
            ),
            elevation: 0,
            borderSide: const BorderSide(
              color: Colors.black,
              width: 3,
            ),
            child: const Icon(
              Icons.games_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView() {
    Widget _listTile(String title, String value) {
      return ListTile(
        dense: true,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Badge(
                elevation: 0,
                shape: BadgeShape.circle,
                padding: const EdgeInsets.all(7),
                badgeContent: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return _listTile('Messages', '2');
            case 1:
              return _listTile('Friends', '7');
            case 2:
            default:
              return _listTile('Events', '!');
          }
        },
      ),
    );
  }

  Widget _directionalBadge() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Badge(
        elevation: 0,
        position: BadgePosition.topEnd(),
        padding: const EdgeInsetsDirectional.only(end: 4),
        badgeColor: Colors.transparent,
        badgeContent: const Icon(Icons.error, size: 16.0, color: Colors.red),
        child: const Text('This is RTL'),
      ),
    );
  }
}
