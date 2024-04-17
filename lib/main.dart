import 'package:elwekala_ecommerce_app/consts/data.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/cart.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/favorite.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/login.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/logout.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/observer.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/onboarding.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/product.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/profile.dart';
import 'package:elwekala_ecommerce_app/controller/cubit/register.dart';
import 'package:elwekala_ecommerce_app/controller/states/cart.dart';
import 'package:elwekala_ecommerce_app/controller/states/favorite.dart';
import 'package:elwekala_ecommerce_app/controller/states/login.dart';
import 'package:elwekala_ecommerce_app/controller/states/logout.dart';
import 'package:elwekala_ecommerce_app/controller/states/onboarding.dart';
import 'package:elwekala_ecommerce_app/controller/states/product.dart';
import 'package:elwekala_ecommerce_app/controller/states/profile.dart';
import 'package:elwekala_ecommerce_app/controller/states/register.dart';
import 'package:elwekala_ecommerce_app/services/cache-helper.dart';
import 'package:elwekala_ecommerce_app/services/dio-helper.dart';
import 'package:elwekala_ecommerce_app/services/hive-helper.dart';
import 'package:elwekala_ecommerce_app/view/screens/bottomnavbar-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/login-screen.dart';
import 'package:elwekala_ecommerce_app/view/screens/onboarding-screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Hive.initFlutter();
  await HiveHelper.init();
  
  Bloc.observer = MyBlocObserver();
  var onboarding = CacheHelper.getData(key: 'onboarding');
  var token = CacheHelper.getData(
    key: "token",
  );
  var id = CacheHelper.getData(key: 'nationalId');
  debugPrint('$onboarding');
  debugPrint(token);
  debugPrint(id);
  if (onboarding == true) {
    if (token != null) {
      screen = BottomNavScreen();
    } else {
      screen = LoginScreen();
    }
  } else {
    screen = const OnBoardingScreens();
  }

  runApp(const WekalaApp());
}

class WekalaApp extends StatelessWidget {
  const WekalaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(InitialOnBoardingState()),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(RegisterInitState()),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => LoginCubit(LoginInitState()),
          lazy: true,
        ),
        BlocProvider(
          create: (context) =>
              ProfileCubit(ProfileInitState())..getUserProfile(),
          lazy: false,
        ),
        BlocProvider(
            create: (context) => ProductCubit(
                  ProductInitState(),
                )..getProducts(),
            lazy: false),
        BlocProvider(
            create: (context) => CartCubit(
                  CartInitState(),
                )..getFromCart(),
            lazy: false),
        BlocProvider(
            create: (context) =>
                FavoriteCubit(FavoriteInitState())..getMyFavorite(),
            lazy: false),
       BlocProvider(
          create: (context) => LogOutCubit(LogOutInitState()),
          lazy: true,
        ),      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE5E5E5),
          useMaterial3: true,
        ),
        home: screen,
      ),
    );
  }
}
