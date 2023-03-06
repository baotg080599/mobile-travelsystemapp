import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/commons/widgets.dart';
// import 'package:room_finder_flutter/components/calling_component.dart';
// import 'package:room_finder_flutter/components/chat_component.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/screens/home_page.dart';

class InboxFragment extends StatefulWidget {
  @override
  _InboxFragmentState createState() => _InboxFragmentState();
}

class _InboxFragmentState extends State<InboxFragment>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : white,
          child: Icon(Icons.add, color: context.iconColor),
        ),
        appBar: careaAppBarWidget(
          context,
          titleText: "Inbox",
          actionWidget: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.search, color: context.iconColor, size: 20),
          ),
          actionWidget2: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.chat, color: context.iconColor, size: 20),
          ),
        ),
        body: HomePage(),
      ),
    );
  }
}
