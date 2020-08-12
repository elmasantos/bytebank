import 'package:flutter/material.dart';

import 'contacts/list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder<double>(
              initialData: 0.2,
              future: Future.delayed(Duration(microseconds: 100))
                  .then((value) => 1.0),
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  opacity: snapshot.data,
                  curve: Curves.easeInCubic,
                  duration: Duration(seconds: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/bytebank-purple-logo.png'),
                  ),
                );
              }),
          Row(
            children: <Widget>[
              _FeatureItem(
                'Transfer',
                Icons.monetization_on,
                onClick: () {
                  _showContactsList(context);
                },
              ),
              _FeatureItem(
                'Transaction Feed',
                Icons.description,
                onClick: () {
                  _showContactsList(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(_createAnimatedRoute(ContactList()));
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Route _createAnimatedRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
