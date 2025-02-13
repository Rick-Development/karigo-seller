import 'package:flutter/material.dart';
import 'package:karingo_seller/common/basewidgets/textfeild/custom_text_feild_widget.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/features/addProduct/controllers/add_product_controller.dart';
import 'package:karingo_seller/utill/color_resources.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/styles.dart';

class TitleAndDescriptionWidget extends StatefulWidget {
  final AddProductController resProvider;
  final int index;
  const TitleAndDescriptionWidget(
      {Key? key, required this.resProvider, required this.index})
      : super(key: key);

  @override
  State<TitleAndDescriptionWidget> createState() =>
      _TitleAndDescriptionWidgetState();
}

class _TitleAndDescriptionWidgetState extends State<TitleAndDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          Text(
            '${getTranslated('inset_lang_wise_title_des', context)}',
            style: robotoRegular.copyWith(
                color: ColorResources.getHint(context),
                fontSize: Dimensions.fontSizeSmall),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          Row(
            children: [
              Text(
                '${getTranslated('product_name', context)}',
                style: robotoRegular.copyWith(
                    color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault),
              ),
              Text(
                '*',
                style: robotoBold.copyWith(
                    color: ColorResources.mainCardFourColor(context),
                    fontSize: Dimensions.fontSizeDefault),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          CustomTextFieldWidget(
            textInputAction: TextInputAction.next,
            controller: TextEditingController(
                text:
                    widget.resProvider.titleControllerList[widget.index].text),
            textInputType: TextInputType.name,
            hintText: getTranslated('product_title', context),
            border: true,
            onChanged: (String text) {
              widget.resProvider.setTitle(widget.index, text);
            },
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraLarge,
          ),
          Row(
            children: [
              Text(
                getTranslated('product_description', context)!,
                style: robotoRegular.copyWith(
                    color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault),
              ),
              Text(
                '*',
                style: robotoBold.copyWith(
                    color: ColorResources.mainCardFourColor(context),
                    fontSize: Dimensions.fontSizeDefault),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          CustomTextFieldWidget(
            isDescription: true,
            controller: TextEditingController(
                text: widget
                    .resProvider.descriptionControllerList[widget.index].text),
            onChanged: (String text) =>
                widget.resProvider.setDescription(widget.index, text),
            textInputType: TextInputType.multiline,
            maxLine: 3,
            border: true,
            hintText: getTranslated('meta_description_hint', context),
          ),
        ],
      ),
    );
  }
}
