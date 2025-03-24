import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chatHistoryList/chatHistoryList.dart';
import 'package:stock_flutter/srceens/exam/exam.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class TabItem {
  final int id;
  final String name;
  final Widget screen;

  TabItem({required this.id, required this.name, required this.screen});
}

class TabbarHistoryAndTest extends StatefulWidget {
  const TabbarHistoryAndTest({super.key});

  @override
  State<TabbarHistoryAndTest> createState() => _TabbarHistoryAndTestState();
}

class _TabbarHistoryAndTestState extends State<TabbarHistoryAndTest> {
  int selectedIndex = 0;

  final List<TabItem> tabs = [
    TabItem(id: 0, name: 'commercialQestions', screen: const ChatHistoryList()),
    TabItem(id: 1, name: 'Mini Test', screen: const Exam()),
  ];

  void handlePressTabBar(int id) {
    setState(() {
      selectedIndex = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              children: tabs.asMap().entries.map((e) {
                int index = e.key;
                var tab = e.value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => handlePressTabBar(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.c_blue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: textCus(
                        context: context,
                        text: tab.name,
                        color: selectedIndex == index
                            ? AppColors.c_white
                            : AppColors.c_black,
                        fontWeight: selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: tabs.map((tab) => tab.screen).toList(),
            ),
          )
        ],
      ),
    );
  }
}
