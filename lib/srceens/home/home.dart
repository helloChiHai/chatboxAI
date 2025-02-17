import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Utils.navigator(context, AppRoutes.welcome);
            },
            child: Text("go to login"),
          ),
          ElevatedButton(
            onPressed: () {
              Utils.navigator(context, AppRoutes.meeting);
            },
            child: Text("go to meeting screen"),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Color.fromARGB(255, 15, 18, 16),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'login',
                        style: TextStyle(
                          fontSize: AppSizeText.sizeText14,
                          color: AppColors.c_white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [TextFormField()],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("show showModalBottomSheet"),
          ),
        ],
      ),
    );
  }
}
