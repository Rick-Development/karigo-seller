import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:karingo_seller/common/basewidgets/custom_snackbar_widget.dart';
import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/features/profile/controllers/profile_controller.dart';
import 'package:karingo_seller/features/profile/domain/models/withdraw_model.dart';
import 'package:karingo_seller/features/wallet/domain/services/wallet_service_interface.dart';
import 'package:karingo_seller/localization/language_constrants.dart';
import 'package:karingo_seller/main.dart';

class WalletController with ChangeNotifier {
  final WalletServiceInterface walletServiceInterface;
  WalletController({required this.walletServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WithdrawModel? withdrawModel;
  List<WithdrawModel> methodList = [];
  int? methodSelectedIndex = 0;
  List<int?> methodsIds = [];

  List<String> inputValueList = [];
  bool validityCheck = false;

  void setTitle(int index, String title) {
    inputFieldControllerList[index].text = title;
  }

  List<TextEditingController> inputFieldControllerList = [];
  void getInputFieldList() {
    inputFieldControllerList = [];
    if (methodList.isNotEmpty) {
      for (int i = 0;
          i < methodList[methodSelectedIndex!].methodFields!.length;
          i++) {
        inputFieldControllerList.add(TextEditingController());
      }
    }
  }

  List<String?> keyList = [];

  void setMethodTypeIndex(int? index, {bool notify = true}) {
    methodSelectedIndex = index;
    keyList = [];
    if (methodList.isNotEmpty) {
      for (int i = 0;
          i < methodList[methodSelectedIndex!].methodFields!.length;
          i++) {
        keyList
            .add(methodList[methodSelectedIndex!].methodFields![i].inputName);
      }
      getInputFieldList();
    }
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> getWithdrawMethods(BuildContext context) async {
    methodList = [];
    methodsIds = [];
    ApiResponse response =
        await walletServiceInterface.getDynamicWithDrawMethod();
    response.response!.data
        .forEach((method) => methodList.add(WithdrawModel.fromJson(method)));
    methodSelectedIndex = 0;
    getInputFieldList();
    for (int index = 0; index < methodList.length; index++) {
      methodsIds.add(methodList[index].id);
    }
    notifyListeners();
  }

  void checkValidity() {
    for (int i = 0; i < inputValueList.length; i++) {
      if (inputValueList[i].isEmpty) {
        inputValueList.clear();
        validityCheck = true;
        notifyListeners();
      }
    }
  }

  Future<ApiResponse> updateBalance(
      String balance, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    for (TextEditingController textEditingController
        in inputFieldControllerList) {
      inputValueList.add(textEditingController.text.trim());
    }
    ApiResponse apiResponse = await walletServiceInterface.withdrawBalance(
        keyList, inputValueList, methodList[methodSelectedIndex!].id, balance);

    Navigator.pop(Get.context!);
    inputValueList.clear();
    inputFieldControllerList.clear();
    Provider.of<ProfileController>(context).getSellerInfo();
    showCustomSnackBarWidget(
        getTranslated('withdraw_request_sent_successfully', Get.context!),
        Get.context!,
        isToaster: true,
        isError: false);
    _isLoading = false;

    notifyListeners();
    return apiResponse;
  }
}
