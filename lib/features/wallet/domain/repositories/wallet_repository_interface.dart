import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class WalletRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getDynamicWithDrawMethod();
  Future<ApiResponse> withdrawBalance(
      List<String?> typeKey, List<String> typeValue, int? id, String balance);
}
