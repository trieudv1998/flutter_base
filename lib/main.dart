import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';
import 'package:flutter_base/core/domain/utils/navigation_services.dart';
import 'package:flutter_base/di.dart';
import 'package:flutter_base/presentation/routes/app_router.dart';
import 'package:flutter_base/presentation/routes/init_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // DI init
  await configureDependencies();

  // Read url from env and use for baseUrl in init
  await RestClientProvider.init();

  // Initial Widget
  await InitRoute().getInitialRoute();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    startLocale: const Locale('vi', 'VN'),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutes _appRoute = AppRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (_, child) => MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        // set property
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        ),
        locale: context.locale,
        title: 'Flutter Base',
        onGenerateRoute: _appRoute.onGenerateRoute,
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            headline2: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            headline3: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            headline4: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            headline5: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            headline6: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            subtitle1: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            subtitle2: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            bodyText1: GoogleFonts.manrope(
              fontSize: 15.sp,
              color: AppColors.b100,
              height: 1.5,
            ),
            bodyText2: GoogleFonts.manrope(
              fontSize: 15.sp,
              color: AppColors.b100,
              height: 1.5,
            ),
            caption: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            button: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
            overline: GoogleFonts.manrope(fontSize: 15.sp, color: AppColors.b100),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
      ),
    );
  }
}
