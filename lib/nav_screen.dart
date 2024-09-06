import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/pages/admin_page.dart';
import 'package:nex_vote/pages/history_page.dart';
import 'package:nex_vote/pages/home_page.dart';
import 'package:nex_vote/pages/vote_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void _navigateToPage(int index) {
    pageController.jumpToPage(index);
  }

  List<CollapsibleItem> _buildCollapsibleItems() {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => _navigateToPage(0),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Admin',
        icon: Icons.person_3_sharp,
        onPressed: () => _navigateToPage(1),
      ),
      CollapsibleItem(
        text: 'Vote',
        icon: Icons.how_to_vote_sharp,
        onPressed: () => _navigateToPage(2),
      ),
      CollapsibleItem(
        text: 'History',
        icon: Icons.history_edu_sharp,
        onPressed: () => _navigateToPage(3),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().backgroundColor,
      body: Row(
        children: [
          CollapsibleSidebar(
            items: _buildCollapsibleItems(),
            showTitle: false,
            sidebarBoxShadow: [],
            borderRadius: 0,
            screenPadding: 0,
            body: SizedBox.shrink(),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                HomePage(),
                AdminPage(),
                VotePage(),
                HistoryPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
