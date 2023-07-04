import 'package:commoncents/components/appbar.dart';
import 'package:commoncents/components/navbar.dart';
import 'package:commoncents/cubit/news_tabbar_cubit.dart';
import 'package:commoncents/cubit/numberpicker_cubit.dart';
import 'package:commoncents/cubit/register_cubit.dart';
import 'package:commoncents/cubit/stake_payout_cubit.dart';
import 'package:commoncents/cubit/stock_data_cubit.dart';
import 'package:commoncents/cubit/ticks_cubit.dart';
import 'package:commoncents/firebase_options.dart';
import 'package:commoncents/pages/auth_pages/login.dart';
import 'package:commoncents/pages/auth_pages/register.dart';
import 'package:commoncents/pages/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:commoncents/cubit/navbar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:commoncents/pages/homepage.dart';
import 'package:commoncents/pages/newspage.dart';
import 'package:commoncents/pages/simulationpage.dart';
import 'package:commoncents/pages/forumpage.dart';
import 'package:commoncents/pages/profilepage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'cubit/login_cubit.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp()
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primaryColor: const Color(0xFF3366ff),
      primaryColorLight: const Color(0xFF6699FF),
      primaryColorDark: const Color(0xFF0E34CC),
      scaffoldBackgroundColor: Colors.white,
      textTheme:
          GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).copyWith(
        // Set the font for headings
        displayLarge: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        // Set the font for small text in buttons
        displaySmall: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          color: Colors.black,
        ),
        // Set the font for numbers
        bodyMedium: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );

    return MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavBarCubit>(
            create: (context) => BottomNavBarCubit(),
          ),
          BlocProvider<StockDataCubit>(
            create: (context) => StockDataCubit(),
          ),
          BlocProvider<LoginStateBloc>(
            create: (context) => LoginStateBloc(),
          ),
          BlocProvider<SignUpStateBloc>(create: (context) => SignUpStateBloc()),
          BlocProvider<NewsTabBarCubit>(create: (context) => NewsTabBarCubit()),
          BlocProvider<StakePayoutCubit>(create: (context)=> StakePayoutCubit()),
          BlocProvider<TicksCubit>(create: (context) => TicksCubit()),
          BlocProvider<CurrentAmountCubit>(create: (context) => CurrentAmountCubit()),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: FutureBuilder(
                    future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    ),
                    builder: ((context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          final User? user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            return const HomePage();
                          }
                          else {
                            return const Onboarding();
                          }
                        default: 
                          return const Center(child: CircularProgressIndicator());
                      }
                    }
                  )
            ),
          ),
        ));
  }

  // Widget _getPage(int index) {
  //   switch (index) {
  //     case 0:
  //       return const HomePage();
  //     case 1:
  //       // return const NewsPage();
  //       return const Text("News page");
  //     case 2:
  //       return SimulationPage();
  //     case 3:
  //       return const ForumPage();
  //     case 4:
  //       return const ProfilePage();
  //     default:
  //       return const Text("not working");
  //   }
  // }
}
