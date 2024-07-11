import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/common/basewidgets/custom_search_field_widget.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/features/chat/controllers/chat_controller.dart';
import 'package:karingo_seller/utill/dimensions.dart';
import 'package:karingo_seller/utill/images.dart';
import 'package:karingo_seller/features/chat/widgets/chat_type_button_widget.dart';

class ChatHeaderWidget extends StatefulWidget {
  const ChatHeaderWidget({Key? key}) : super(key: key);

  @override
  State<ChatHeaderWidget> createState() => _ChatHeaderWidgetState();
}

class _ChatHeaderWidgetState extends State<ChatHeaderWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(builder: (context, chat, _) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
            Dimensions.paddingSizeDefault,
            Dimensions.paddingSizeDefault,
            Dimensions.paddingSizeDefault,
            Dimensions.paddingSizeSmall),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: CustomSearchFieldWidget(
                  controller: _textEditingController,
                  hint: getTranslated('search', context),
                  prefix: Images.iconsSearch,
                  iconPressed: () => () {},
                  onSubmit: (text) => () {},
                  onChanged: (value) {
                    if (value.toString().isNotEmpty) {
                      chat.searchedChatList(context, value);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    ChatTypeButtonWidget(
                        text: getTranslated('customer', context), index: 0),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    ChatTypeButtonWidget(
                        text: getTranslated('delivery-man', context), index: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
