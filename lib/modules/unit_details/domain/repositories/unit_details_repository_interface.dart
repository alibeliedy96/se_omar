import 'package:dartz/dartz.dart';
import 'package:mr_omar/modules/unit_details/domain/models/unit_details_response.dart';
import '../../../../../../core/api/error/error_handler/failure.dart';
import '../models/create_review_response.dart';
import '../request/create_review_request.dart';


abstract class UnitDetailsRepositoryInterface {
  Future<Either<Failure, UnitDetailsResponse>> unitDetails({required String id});
  Future<Either<Failure, CreateReviewResponse>> createReview({required CreateReviewRequestModel createReviewRequestModel});

}