import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/features/notification/controllers/notification_controller.dart';
import 'package:karingo_seller/features/product/domain/models/product_model.dart';
import 'package:karingo_seller/features/bank_info/controllers/bank_info_controller.dart';
import 'package:karingo_seller/features/delivery_man/controllers/delivery_man_controller.dart';
import 'package:karingo_seller/features/order/controllers/order_controller.dart';
import 'package:karingo_seller/features/product/controllers/product_controller.dart';
import 'package:karingo_seller/features/profile/controllers/profile_controller.dart';
import 'package:karingo_seller/features/shipping/controllers/shipping_controller.dart';
import 'package:karingo_seller/features/splash/controllers/splash_controller.dart';
import 'package:karingo_seller/utill/color_resources.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/images.dart';
import 'package:karingo_seller/utill/styles.dart';
import 'package:karingo_seller/common/basewidgets/custom_loader_widget.dart';
import 'package:karingo_seller/features/home/widgets/chart_widget.dart';
import 'package:karingo_seller/features/home/widgets/completed_order_widget.dart';
import 'package:karingo_seller/features/home/widgets/on_going_order_widget.dart';
import 'package:karingo_seller/features/product/widgets/stock_out_product_widget.dart';
import 'package:karingo_seller/features/notification/screens/notification_screen.dart';
import 'package:karingo_seller/features/product/screens/most_popular_product_screen.dart';
import 'package:karingo_seller/features/product/screens/top_selling_product_screen.dart';
import 'package:karingo_seller/features/delivery_man/widgets/top_delivery_man_view_widget.dart';

class HomePageScreen extends StatefulWidget {
  final Function? callback;
  const HomePageScreen({Key? key, this.callback}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<ProfileController>(context, listen: false).getSellerInfo();
    Provider.of<BankInfoController>(context, listen: false)
        .getBankInfo(context);
    Provider.of<OrderController>(context, listen: false)
        .getOrderList(context, 1, 'all');
    Provider.of<BankInfoController>(context, listen: false)
        .getAnalyticsFilterData(context, 'overall');
    Provider.of<SplashController>(context, listen: false).getColorList();
    Provider.of<ProductController>(context, listen: false)
        .getStockOutProductList(1, 'en');
    Provider.of<ProductController>(context, listen: false)
        .getMostPopularProductList(1, context, 'en');
    Provider.of<ProductController>(context, listen: false)
        .getTopSellingProductList(1, context, 'en');
    Provider.of<ShippingController>(context, listen: false)
        .getCategoryWiseShippingMethod();
    Provider.of<ShippingController>(context, listen: false)
        .getSelectedShippingMethodType(context);
    Provider.of<DeliveryManController>(context, listen: false)
        .getTopDeliveryManList(context);
    Provider.of<BankInfoController>(context, listen: false)
        .getDashboardRevenueData(context, 'yearEarn');
    Provider.of<NotificationController>(context, listen: false)
        .getNotificationList(1);
  }

  @override
  void initState() {
    _loadData(context, false);
    Provider.of<BankInfoController>(context, listen: false)
        .setAnalyticsFilterName(context, 'overall', false);
    Provider.of<BankInfoController>(context, listen: false)
        .setAnalyticsFilterType(0, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width / 1.4;
    return Scaffold(
      body: Consumer<OrderController>(
        builder: (context, order, child) {
          return order.orderModel != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<BankInfoController>(context, listen: false)
                        .setAnalyticsFilterName(context, 'overall', true);
                    Provider.of<BankInfoController>(context, listen: false)
                        .setAnalyticsFilterType(0, true);
                    await _loadData(context, true);
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        elevation: 0,
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).highlightColor,
                        title: Image.asset(Images.logoWithAppName, height: 35),
                        actions: [
                          Consumer<NotificationController>(
                              builder: (context, notificationController, _) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const NotificationScreen())),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        Dimensions.paddingSizeDefault,
                                        Dimensions.paddingSizeSmall,
                                        Dimensions.paddingSizeDefault,
                                        0),
                                    child: Icon(CupertinoIcons.bell,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 18,
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            radius: 8,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Text(
                                                  '${notificationController.notificationModel?.newNotificationItem ?? 0}',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ))),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            OngoingOrderWidget(
                              callback: widget.callback,
                            ),
                            CompletedOrderWidget(callback: widget.callback),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Consumer<ProductController>(
                                builder: (context, prodProvider, child) {
                              List<Product> productList;
                              productList = prodProvider.stockOutProductList;
                              return productList.isNotEmpty
                                  ? Container(
                                      height: limitedStockCardHeight,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorResources.getPrimary(
                                                      context)
                                                  .withOpacity(.05),
                                              spreadRadius: -3,
                                              blurRadius: 12,
                                              offset:
                                                  Offset.fromDirection(0, 6))
                                        ],
                                      ),
                                      child: StockOutProductView(
                                          scrollController: _scrollController,
                                          isHome: true))
                                  : const SizedBox();
                            }),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const ChartWidget(),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const TopSellingProductScreen(isMain: true),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                color: Theme.of(context).primaryColor,
                                child: const MostPopularProductScreen(
                                    isMain: true)),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            const TopDeliveryManViewWidget(isMain: true)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : const CustomLoaderWidget();
        },
      ),
    );
  }
}
