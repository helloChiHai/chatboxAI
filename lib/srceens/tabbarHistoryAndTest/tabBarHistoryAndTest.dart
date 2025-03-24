import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/chatHistoryList/chatHistoryList.dart';
import 'package:stock_flutter/srceens/exam/exam.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class TabbarHistoryAndTest extends StatefulWidget {
  const TabbarHistoryAndTest({super.key});

  @override
  State<TabbarHistoryAndTest> createState() => _TabbarHistoryAndTestState();
}

class _TabbarHistoryAndTestState extends State<TabbarHistoryAndTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.c_blue,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              tabs: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: textCus(
                    context: context,
                    text: 'commercialQestions',
                    color: _tabController.index == 0
                        ? AppColors.c_white
                        : AppColors.c_black,
                    fontWeight: _tabController.index == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: textCus(
                    context: context,
                    text: 'Bài text',
                    color: _tabController.index == 1
                        ? AppColors.c_white
                        : AppColors.c_black,
                    fontWeight: _tabController.index == 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ChatHistoryList(),
                Exam(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
