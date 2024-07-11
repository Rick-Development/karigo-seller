import 'package:karingo_seller/data/model/response/base/api_response.dart';
import 'package:karingo_seller/interface/repository_interface.dart';

abstract class ProductRepositoryInterface implements RepositoryInterface {
  Future<ApiResponse> getSellerProductList(
      String sellerId, int offset, String languageCode, String search);
  Future<ApiResponse> getPosProductList(int offset, List<String> ids);
  Future<ApiResponse> getSearchedPosProductList(
      String search, List<String> ids);
  Future<ApiResponse> getStockLimitedProductList(
      int offset, String languageCode);
  Future<ApiResponse> getMostPopularProductList(
      int offset, String languageCode);
  Future<ApiResponse> getTopSellingProductList(int offset, String languageCode);
}
