import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/helper/network_info.dart';
import 'package:karingo_seller/helper/notification_helper.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/features/order/controllers/order_controller.dart';
import 'package:karingo_seller/features/profile/controllers/profile_controller.dart';
import 'package:karingo_seller/utill/color_resources.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/images.dart';
import 'package:karingo_seller/utill/styles.dart';
import 'package:karingo_seller/features/home/screens/home_page_screen.dart';
import 'package:karingo_seller/features/menu/widgets/menu_widget.dart';
import 'package:karingo_seller/features/order/screens/order_screen.dart';
import 'package:karingo_seller/features/refund/screens/refund_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileController>(context, listen: false).getSellerInfo();

    _screens = [
      HomePageScreen(callback: () {
        setState(() {
          setPage(1);
        });
      }),
      const OrderScreen(),
      const RefundScreen(),
    ];

    NetworkInfo.checkConnectivity(context);

    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      Provider.of<OrderController>(context, listen: false)
          .getOrderList(context, 1, 'all');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (_pageIndex != 0) {
          setPage(0);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.hintTextColor,
          selectedFontSize: Dimensions.fontSizeSmall,
          unselectedFontSize: Dimensions.fontSizeSmall,
          selectedLabelStyle: robotoBold,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Images.home, getTranslated('home', context), 0),
            _barItem(Images.order, getTranslated('my_order', context), 1),
            _barItem(Images.refund, getTranslated('refund', context), 2),
            _barItem(Images.menu, getTranslated('menu', context), 3)
          ],
          onTap: (int index) {
            if (index != 3) {
              setState(() {
                setPage(index);
              });
            } else {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) => const MenuBottomSheetWidget());
            }
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding:
            const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                width: index == _pageIndex
                    ? Dimensions.iconSizeLarge
                    : Dimensions.iconSizeMedium,
                child: Image.asset(
                  icon,
                  color: index == _pageIndex
                      ? Theme.of(context).primaryColor
                      : ColorResources.hintTextColor,
                )),
          ],
        ),
      ),
      label: label,
    );
  }

  void setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
