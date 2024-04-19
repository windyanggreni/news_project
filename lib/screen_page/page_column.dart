import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageColumn extends StatelessWidget {
  const PageColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Column'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('We move under cover and we move as one'),
          const Text('Through the night, we have one shot to live another day'),
          const Text('We cannot let a stray gunshot give us away'),
          const Text('We will fight up close, seize the moment and stay in it'),
          const Text('It’s either that or meet the business end of a bayonet'),
          const Text('The code word is ‘Rochambeau,’ dig me?'),
          Text('Rochambeau!',
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 2.0)),
        ],
      ),
    );
  }
}

class PageColumnRow extends StatelessWidget {
  const PageColumnRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Column dan Row'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  size: 65,
                  color: Colors.green,
                ),
                Text('Menu Home')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.list,
                  size: 65,
                  color: Colors.green,
                ),
                Text('Menu Berita')
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off,
                  size: 65,
                  color: Colors.green,
                ),
                Text('Menu Profil')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageListHorizontal extends StatelessWidget {
  const PageListHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('List Horizontal'),
      ),
      body: SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(50, (index) {
            return Card(
              child: Center(child: Text('Horizontal ke : ${index}')),
            );
          }),
        ),
      ),
    );
  }
}
