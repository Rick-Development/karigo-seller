import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/features/barcode/controllers/barcode_controller.dart';
import 'package:karingo_seller/features/notification/controllers/notification_controller.dart';
import 'package:karingo_seller/features/order_details/controllers/order_details_controller.dart';
import 'package:karingo_seller/features/product_details/controllers/productDetailsController.dart';
import 'package:karingo_seller/features/wallet/controllers/wallet_controller.dart';
import 'package:karingo_seller/localization/app_localization.dart';
import 'package:karingo_seller/features/auth/controllers/auth_controller.dart';
import 'package:karingo_seller/features/settings/controllers/business_controller.dart';
import 'package:karingo_seller/features/pos/controllers/cart_controller.dart';
import 'package:karingo_seller/features/chat/controllers/chat_controller.dart';
import 'package:karingo_seller/features/coupon/controllers/coupon_controller.dart';
import 'package:karingo_seller/features/delivery_man/controllers/delivery_man_controller.dart';
import 'package:karingo_seller/features/emergency_contract/controllers/emergency_contact_controller.dart';
import 'package:karingo_seller/features/language/controllers/language_controller.dart';
import 'package:karingo_seller/localization/controllers/localization_controller.dart';
import 'package:karingo_seller/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:karingo_seller/features/order/controllers/location_controller.dart';
import 'package:karingo_seller/features/order/controllers/order_controller.dart';
import 'package:karingo_seller/features/product/controllers/product_controller.dart';
import 'package:karingo_seller/features/review/controllers/product_review_controller.dart';
import 'package:karingo_seller/features/profile/controllers/profile_controller.dart';
import 'package:karingo_seller/features/refund/controllers/refund_controller.dart';
import 'package:karingo_seller/features/addProduct/controllers/add_product_controller.dart';
import 'package:karingo_seller/features/shipping/controllers/shipping_controller.dart';
import 'package:karingo_seller/features/shop/controllers/shop_controller.dart';
import 'package:karingo_seller/features/splash/controllers/splash_controller.dart';
import 'package:karingo_seller/theme/controllers/theme_controller.dart';
import 'package:karingo_seller/features/bank_info/controllers/bank_info_controller.dart';
import 'package:karingo_seller/features/transaction/controllers/transaction_controller.dart';
import 'package:karingo_seller/theme/dark_theme.dart';
import 'package:karingo_seller/theme/light_theme.dart';
import 'package:karingo_seller/utill/app_constants.dart';
import 'package:karingo_seller/features/splash/screens/splash_screen.dart';
import 'di_container.dart' as di;
import 'notification/my_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAKU-DI2rU7MeacKmFx1noxtsK-CFNy5GM",
              authDomain: "sixvally-ecommerce.firebaseapp.com",
              projectId: "sixvally-ecommerce",
              storageBucket: "sixvally-ecommerce.appspot.com",
              messagingSenderId: "975837518429",
              appId: "1:975837518429:web:91cf124f328b84449f0bb4"));
    } else {
      await Firebase.initializeApp();
    }
  }
  await di.init();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeController>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopController>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BankInfoController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BusinessController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<TransactionController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<AddProductController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductReviewController>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShippingController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<DeliveryManController>()),
      ChangeNotifierProvider(create: (context) => di.sl<RefundController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<BottomMenuController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<EmergencyContactController>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponController>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationController>()),
      ChangeNotifierProvider(create: (context) => di.sl<WalletController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<OrderDetailsController>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductDetailsController>()),
      ChangeNotifierProvider(create: (context) => di.sl<BarcodeController>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeController>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationController>(context).locale,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            child: child!);
      },
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: locals,
      home: const SplashScreen(),
    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
