import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'common/safe_area_height.dart';
import 'training_plan_board_page.dart';
import 'training_plan_point_page.dart';
import 'training_plan_rule_page.dart';
import 'training_plna_key_factor_page.dart';

class TrainingPlanTopPage extends StatefulWidget {
  @override
  _TrainingPlanPageState createState() => _TrainingPlanPageState();
}

class _TrainingPlanPageState extends State<TrainingPlanTopPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String appBarTitle = ModalRoute.of(context).settings.arguments;

    //前画面からSafeAreaの高さを連携しておく（BoardPageと本ページのリロード順により、本ページからは送れない）
    //final SafeAreaHeight argHeight = ModalRoute.of(context).settings.arguments;
    final _childPageList = [
      TrainingPlanBoardPage(),
      TrainingPlanRulePage(),
      TrainingPlanKeyFactorPage(),
      TrainingPlanPointPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Color(0xff202f55),
      ),
      body: _childPageList[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Color(0xff202f55),
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Color(0xfffff3b8),
          selectedItemIconColor: Colors.black,
          selectedItemLabelColor: Colors.white,
          unselectedItemIconColor: Colors.white,
          unselectedItemLabelColor: Colors.white,
          showSelectedItemShadow: false,
          //barHeight: 50,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.border_all_rounded,
            label: '戦略ボード',
          ),
          FFNavigationBarItem(
            iconData: Icons.rule_sharp,
            label: 'ルール',
          ),
          FFNavigationBarItem(
            iconData: Icons.vpn_key_outlined,
            label: 'キーファクター',
          ),
          FFNavigationBarItem(
            iconData: Icons.flag_outlined,
            label: 'ポイント',
          ),
        ],
      ),
    );
  }
}
