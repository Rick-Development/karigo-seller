import 'package:flutter/material.dart';
import 'package:karingo_seller/features/delivery_man/domain/model/collected_cash_model.dart';
import 'package:karingo_seller/helper/date_converter.dart';
import 'package:karingo_seller/helper/price_converter.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/styles.dart';

class DeliveryManCollectedCashCardWidget extends StatelessWidget {
  final CollectedCash collectedCash;
  final int? index;
  const DeliveryManCollectedCashCardWidget(
      {Key? key, required this.collectedCash, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,
          Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(.125),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(1, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.paddingSizeExtraSmall),
                      topRight:
                          Radius.circular(Dimensions.paddingSizeExtraSmall)),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(.07),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(0, 1))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: '${getTranslated('xid', context)}# ',
                        style: robotoRegular),
                    TextSpan(
                      text: collectedCash.id.toString(),
                      style: robotoMedium,
                    )
                  ])),
                  Container(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.07),
                      borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraSmall),
                    ),
                    child: Text(
                      PriceConverter.convertPrice(
                          context, double.parse(collectedCash.credit!)),
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimensions.paddingSizeSmall,
                  left: Dimensions.paddingSizeSmall,
                  top: Dimensions.paddingSizeExtraSmall,
                  bottom: Dimensions.paddingSizeExtraSmall),
              child: Text(
                  DateConverter.localDateToIsoStringAMPM(
                      DateTime.parse(collectedCash.createdAt!)),
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).hintColor)),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
          ],
        ),
      ),
    );
  }
}