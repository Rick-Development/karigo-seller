import 'package:http/http.dart' as http;
import 'package:karingo_seller/features/profile/domain/models/profile_body.dart';
import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/features/profile/domain/models/profile_info.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class BankInfoRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> chartFilterData(String? type);
  Future<http.StreamedResponse> updateBank(
      ProfileInfoModel userInfoModel, ProfileBody seller, String token);
  String getBankToken();
  Future<ApiResponse> getOrderFilterData(String? type);
}
