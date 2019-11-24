import 'package:flutter/material.dart';
import 'package:flutter_news/pages/Bookmark.dart';
import 'package:flutter_news/pages/Home.dart';
import 'package:flutter_news/pages/Search.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.blue),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _tabList = [HomePage(), Search(), Bookmark()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(top: 8, left: 8),
          width: double.infinity,
          child: Text(
            'N',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
          ),
        ),
        title: Text('Flutter News'),
        actions: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => "",
            ),
          )
        ],
      ),
      body: _tabList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) async {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            title: Text('News Saved'),
          ),
        ],
      ),
    );
  }
}
