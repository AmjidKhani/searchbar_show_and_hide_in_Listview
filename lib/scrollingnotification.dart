import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class scrollingg extends StatefulWidget {
  const scrollingg({Key? key}) : super(key: key);

  @override
  State<scrollingg> createState() => _scrollinggState();
}

class _scrollinggState extends State<scrollingg> {
  ScrollController? _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller?.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {}

  bool isvissible = false;

  Future<void> _handleRefresh() async {
    setState(() {
      isvissible = !isvissible;
    });
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Status"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            //color: Colors.green,

            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Visibility(
                  visible: isvissible,
                  child: Expanded(child: CupertinoSearchTextField())),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  _onStartScroll(scrollNotification.metrics);
                }
                return false;
              },
              child: LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text("Index : $index"));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      isvissible = false;
    });
  }
}
