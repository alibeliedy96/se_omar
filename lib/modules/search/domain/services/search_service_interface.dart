
import 'package:dartz/dartz.dart';
import '../../../../core/api/error/error_handler/failure.dart';
import '../models/search_response.dart';


 

abstract class SearchServiceInterface{

  Future<Either<Failure, SearchResponse>> search({
    required int page,required String searchKey
  });




}