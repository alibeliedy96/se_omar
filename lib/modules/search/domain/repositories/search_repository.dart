import 'package:dartz/dartz.dart';
import '../../../../core/api/data_source/end_point.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/search_response.dart';
import '../../../../../../core/api/shared/shared_methods.dart';
import 'search_repository_interface.dart';

class SearchRepository implements SearchRepositoryInterface{

  SearchRepository( );

  @override
  Future<Either<Failure, SearchResponse>> search({
    required int page,required String searchKey
  }) async {
    return await handleResponse(
        endPoint: "${EndPoints.search}$searchKey",
        asObject: (e) => SearchResponse.fromJson(e),
        method: DioMethod.get,
        page: page,
        query: {
            "per_page": 50
        }



    );
  }






}