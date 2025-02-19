import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_bloc.dart';
import 'package:stock_flutter/bloc/languageBloc/language_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_bloc.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_event.dart';
import 'package:stock_flutter/bloc/themeBloc/theme_state.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/constants/localization.dart';
import 'package:stock_flutter/routes/app_routes.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController inputController = TextEditingController();
  bool showIconFullTextField = false;
  int maxLines = 10;
  double borderRadius = 30;
  bool showFullInputChat = false;

  @override
  void initState() {
    super.initState();
    inputController.addListener(getTextLineCount);
  }

  @override
  void dispose() {
    inputController.removeListener(getTextLineCount);
    inputController.dispose();
    super.dispose();
  }

  void getTextLineCount() {
    final span = TextSpan(
      text: inputController.text,
      style: TextStyle(fontSize: AppSizeText.sizeText12),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    final numLines = tp.computeLineMetrics().length;

    setState(() {
      showIconFullTextField = numLines >= 4;

      borderRadius = numLines >= 2 ? 20 : 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final currentLocale = context.read<LanguageBloc>().state.locale;
              final newLocale = currentLocale.languageCode == 'vi'
                  ? Locale('en')
                  : Locale('vi');
              context
                  .read<LanguageBloc>()
                  .add(ChangeLanguage(locale: newLocale));
            },
            icon: const Icon(
              Icons.language,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            icon: const Icon(
              Icons.brightness_6,
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         Utils.navigator(context, AppRoutes.welcome);
      //       },
      //       child: Text("go to login"),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Utils.navigator(context, AppRoutes.meeting);
      //       },
      //       child: Text("go to meeting screen"),
      //     ),
      //   ],
      // ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return Container(
            decoration: BoxDecoration(
              color: themeState.themeMode == ThemeMode.dark
                  ? AppColors.c_darkmode
                  : AppColors.backgroundColor,
            ),
            padding: EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // hình ảnh + ds chat lưu trữ
                Container(
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.messenger_outline,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://img.amiami.jp/images/product/review/191/TOY-RBT-4827_01.jpg?a8=YRvtwRALNEponvKc_hc6iFP2Fo9wjLvg4L0sTMfLuRzCu.zLNCuEusHcDFvoJFngVFPg_6uFSqvYuRQoNFP2tjZ5xs00000003017001'),
                        ),
                      )
                    ],
                  ),
                ),
                // text chao mung
                showFullInputChat
                    ? SizedBox(height: 10)
                    : textCus(
                        context: context,
                        text: 'Xin chào Vương Chí Hải!',
                        fontSize: AppSizeText.sizeText30,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center),
                Expanded(
                  flex: showFullInputChat ? 1 : 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.c_gray,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .stretch, // Đảm bảo chiều cao bằng nhau
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: inputController,
                                minLines: 1,
                                maxLines: maxLines,
                                style:
                                    TextStyle(fontSize: AppSizeText.sizeText12),
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .translate('askChatBotAI'),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: AppSizeText.sizeText12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: showIconFullTextField
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.end,
                              children: [
                                if (showIconFullTextField)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showFullInputChat = !showFullInputChat;
                                      });
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      color: Colors.amber,
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 223, 230, 230),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.send,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
