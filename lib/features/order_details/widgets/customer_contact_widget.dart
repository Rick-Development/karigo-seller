import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/features/order/domain/models/order_model.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/features/splash/controllers/splash_controller.dart';
import 'package:karingo_seller/utill/color_resources.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/images.dart';
import 'package:karingo_seller/utill/styles.dart';
import 'package:karingo_seller/common/basewidgets/custom_image_widget.dart';

class CustomerContactWidget extends StatelessWidget {
  final Order? orderModel;
  const CustomerContactWidget({Key? key, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        orderModel!.isGuest!
            ? Text(
                '${getTranslated('customer_information', context)} (${getTranslated('guest_customer', context)})',
                style: robotoMedium.copyWith(
                  color: ColorResources.titleColor(context),
                  fontSize: Dimensions.fontSizeLarge,
                ))
            : Text('${getTranslated('customer_information', context)}',
                style: robotoMedium.copyWith(
                  color: ColorResources.titleColor(context),
                  fontSize: Dimensions.fontSizeLarge,
                )),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImageWidget(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    image:
                        '${Provider.of<SplashController>(context, listen: false).baseUrls!.customerImageUrl}/${orderModel?.customer?.image}')),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    orderModel!.isGuest!
                        ? '${orderModel!.shippingAddressData != null ? orderModel!.shippingAddressData?.contactPersonName : '${orderModel?.billingAddressData?.contactPersonName}'}'
                        : '${orderModel!.customer?.fName ?? ''} '
                            '${orderModel!.customer?.lName ?? ''}',
                    style: titilliumRegular.copyWith(
                        color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                const SizedBox(
                  height: Dimensions.paddingSizeExtraSmall,
                ),
                Row(
                  children: [
                    Image.asset(Images.phone, width: 15),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                        orderModel!.isGuest!
                            ? '${orderModel!.shippingAddressData != null ? orderModel!.shippingAddressData?.phone : '${orderModel?.billingAddressData?.phone}'}'
                            : '${orderModel!.customer?.phone}',
                        style: titilliumRegular.copyWith(
                            color: ColorResources.titleColor(context),
                            fontSize: Dimensions.fontSizeDefault)),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeExtraSmall,
                ),
                Row(
                  children: [
                    Image.asset(Images.email, width: 15),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    orderModel!.isGuest!
                        ? Text(
                            '${orderModel!.shippingAddressData != null ? orderModel!.shippingAddressData?.email : '${orderModel?.billingAddressData?.email}'}',
                            style: titilliumRegular.copyWith(
                                color: ColorResources.titleColor(context),
                                fontSize: Dimensions.fontSizeDefault))
                        : Text(orderModel!.customer?.email ?? '',
                            style: titilliumRegular.copyWith(
                                color: ColorResources.titleColor(context),
                                fontSize: Dimensions.fontSizeDefault)),
                  ],
                ),
              ],
            ))
          ],
        )
      ]),
    );
  }
}
