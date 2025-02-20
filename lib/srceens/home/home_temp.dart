      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         final currentLocale = context.read<LanguageBloc>().state.locale;
      //         final newLocale = currentLocale.languageCode == 'vi'
      //             ? Locale('en')
      //             : Locale('vi');
      //         context
      //             .read<LanguageBloc>()
      //             .add(ChangeLanguage(locale: newLocale));
      //       },
      //       icon: const Icon(
      //         Icons.language,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         context.read<ThemeBloc>().add(ToggleThemeEvent());
      //       },
      //       icon: const Icon(
      //         Icons.brightness_6,
      //       ),
      //     ),
      //   ],
      // ),
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