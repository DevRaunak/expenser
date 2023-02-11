import 'package:expenser/screens/home/frags/frag_stats/frag_stats_page.dart';
import 'package:expenser/screens/home/frags/frag_transaction/frag_trasanction_page.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  var isLight;

  var arrFrags = [
   FragTransactionPage(),
   FragStatsPage()
  ];

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: arrFrags[selectedIndex],
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBottomNavigationBar(){
    return BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      currentIndex: selectedIndex,
      selectedIconTheme: IconThemeData(
          size: 25
      ),
      unselectedIconTheme: IconThemeData(
        size: 19,
      ),
      onTap: (index) {
        selectedIndex = index;
        setState(() {});
      },
      backgroundColor:
      isLight ? MyColor.secondaryWColor : MyColor.secondaryBColor,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.inbox_outlined,
              color:
              isLight ? MyColor.secondaryBColor.withOpacity(0.5) : MyColor.secondaryWColor..withOpacity(0.5),
            ),
            label: '',
            activeIcon: Icon(
              Icons.inbox_rounded,
              color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
            ),
            tooltip: 'Transaction'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_outlined,
              color:
              isLight ? MyColor.secondaryBColor.withOpacity(0.5) : MyColor.secondaryWColor.withOpacity(0.5),
            ),
            label: '',
            activeIcon: Icon(
              Icons.account_balance,
              color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
            ),
            tooltip: 'Stats')
      ],
    );
  }
}
