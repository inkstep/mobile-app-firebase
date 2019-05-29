import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/page/info_gathering.dart';

class JourneyPage extends StatefulWidget {
  @override
  _JourneyPageState createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _isLoading = false;
    var _length = 1;

    if (!_isLoading) {
      _controller.forward();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : FadeTransition(
              opacity: _animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(context),
                  _buildJourneyCards(_length),
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0),
                  ),
                ],
              ),
            ),
    );
  }

  Expanded _buildJourneyCards(int _length) {
    return Expanded(
      key: _backdropKey,
      flex: 1,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            print('ScrollNotification = ${_pageController.page}');
            var currentPage = _pageController.page.round().toInt();
            if (_currentPageIndex != currentPage) {
              setState(() => _currentPageIndex = currentPage);
            }
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            if (index == _length) {
              return AddCard();
            } else {
              return JourneyCard();
            }
          },
          itemCount: _length + 1,
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ShadowImage(),
          Text(
            'Welcome back,',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            // margin: EdgeInsets.only(top: 22.0),
            child: Text(
              'Natasha',
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Colors.white),
            ),
          ),
          Container(height: 16.0),
          Text(
            'You have some journey tasks to complete',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            height: 16.0,
          )
        ],
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).backgroundColor;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push<dynamic>(context,
                MaterialPageRoute<dynamic>(builder: (BuildContext context) {
              return InfoScreen();
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 52.0,
                  color: textColor,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  'Start a new journey',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef JourneyGetter<T, V> = V Function(T value);

class JourneyCard extends StatelessWidget {
  JourneyCard();

  @override
  Widget build(BuildContext context) {
//    var heroIds = getHeroIds(task);
    return GestureDetector(
      onTap: () {
        print('Existing card tapped');
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(
                flex: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4.0),
                // Should be Hero-d
                child: Text(
                  'Ricky',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: baseColors['gray']),
                ),
              ),
              Container(
                // Should be Hero-d
                child: Text('Dove',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).accentColor)),
              ),
              Spacer(),
              //Journey progression?
            ],
          ),
        ),
      ),
    );
  }
}
