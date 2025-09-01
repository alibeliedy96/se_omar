
import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/search/domain/models/search_response.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../repositories/search_repository_interface.dart';
import 'search_service_interface.dart';

class SearchService implements SearchServiceInterface{
  SearchRepositoryInterface searchRepositoryInterface;

  SearchService({required this.searchRepositoryInterface});



  @override
  Future<Either<Failure, SearchResponse>> search({required int page, required String searchKey}) async {
    return await searchRepositoryInterface.search( page: page,searchKey: searchKey  );
  }






}

 

