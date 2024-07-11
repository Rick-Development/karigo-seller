import 'package:flutter/material.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/images.dart';
import 'package:karingo_seller/utill/styles.dart';

class PosNoProductWidget extends StatelessWidget {
  const PosNoProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.posPlaceholder, width: 50, height: 50),
              Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Text(
                    getTranslated('scan_item_or_add_from_item', context)!,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).hintColor),
                    textAlign: TextAlign.center,
                  )),
            ]),
      ),
    );
  }
}
