import 'package:commoncents/components/appbar.dart';
import 'package:commoncents/components/navbar.dart';
import 'package:commoncents/cubit/news_tabbar_cubit.dart';
import 'package:commoncents/cubit/numberpicker_cubit.dart';
import 'package:commoncents/cubit/register_cubit.dart';
import 'package:commoncents/cubit/stake_payout_cubit.dart';
import 'package:commoncents/cubit/stock_data_cubit.dart';
import 'package:commoncents/cubit/ticks_cubit.dart';
import 'package:commoncents/pages/auth_pages/login.dart';
import 'package:commoncents/pages/auth_pages/register.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MaterialApp(home: MainApp()));
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
          BlocProvider<CurrentAmountCubit>(create: (context) => CurrentAmountCubit())
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            theme: theme,
            home: BlocBuilder<BottomNavBarCubit, int>(
              builder: (context, selectedIndex) {
                List<String> barTitle = [
                  "CommonCents",
                  "Trading News",
                  "Trading Simulation",
                  "Forum",
                  "User Profile"
                ];
                // return Scaffold(
                //   backgroundColor: Colors.white,
                //   appBar: CustomAppBar(
                //     title: barTitle[selectedIndex],
                //   ),
                //   body: _getPage(selectedIndex),
                //   bottomNavigationBar: const BottomNavBar(),
                // );
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(50, 90, 56, 90),
                        child: Text("Welcome to our CommonCents Community",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                      const Image(image: AssetImage('assets/images/trading-onboarding.jpg'),
                        height: 170,
                        width: 217,
                      ),
                      const Padding(
                        padding:  EdgeInsets.fromLTRB(0, 36, 0, 0),
                        child:  Text("Zero real money.",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                      ),
                      const Text("Experience real trading.",
                        style: TextStyle(
                          fontSize: 15
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 42, 0, 42),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {}, 
                              icon: const FaIcon(FontAwesomeIcons.solidCircle,
                                size: 10,
                                color: Color(0xFF5F5F5F),
                              )
                            ),
                            IconButton(
                              onPressed: () {}, 
                              icon: const FaIcon(FontAwesomeIcons.solidCircle,
                                size: 10,
                                color: Color(0xFFD9D9D9),
                              )
                            ),
                            IconButton(
                              onPressed: () {}, 
                              icon: const FaIcon(FontAwesomeIcons.solidCircle,
                                size: 10,
                                color: Color(0xFFD9D9D9),
                              )
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterView();
                              }
                            )
                          );
                        },  
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3366FF),
                          fixedSize: const Size(298, 44)
                        ),
                        child: const Text("Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginView();
                                }
                              )
                            );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9D9D9),
                            fixedSize: const Size(298, 44)
                          ),
                          child: const Text("Log In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto',
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ],
                    ),
                  )
                );
              },
            ),
          ),
        ));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return NewsPage();
      case 2:
        return SimulationPage();
      case 3:
        return ForumPage();
      case 4:
        return ProfilePage();
      default:
        return Container(color: Colors.red);
    }
  }
}
