// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:room_finder_flutter/get_it.dart';
// import 'package:room_finder_flutter/main.dart';
// import 'package:room_finder_flutter/provider/AuthProvider.dart';
// import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
// import 'package:room_finder_flutter/utils/AppTheme.dart';

// class App extends StatelessWidget {
//   const App({super.key});
//   // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: getIt.get<AuthProvider>(),
//       child: MaterialApp(
//         scrollBehavior: SBehavior(),
//         navigatorKey: navigatorKey,
//         title: 'Room Finder',
//         debugShowCheckedModeBanner: false,
//         theme: AppThemeData.lightTheme,
//         darkTheme: AppThemeData.darkTheme,
//         themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
//         home: RFEmailSignInScreen(),
//       ),
//     );
//   }
// }