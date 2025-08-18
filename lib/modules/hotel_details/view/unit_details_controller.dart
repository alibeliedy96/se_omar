import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
import '../../../utils/fake_data_generator.dart';
import '../domain/models/unit_details_response.dart';
import '../logic/unit_details_cubit/unit_details_cubit.dart';



class UnitDetailsController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final UnitDetailsCubit _cubit = UnitDetailsCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  bool _isLoading = true;
  UnitDetailsData? _unitDetails;
  UnitDetailsData? _fakeUnitDetails;
  // ==========================
  //      Public Getters
  // ==========================
  bool get isLoading => _isLoading;
  UnitDetailsData? get unitDetails =>_isLoading?_fakeUnitDetails: _unitDetails;

  // ==========================
  //      Initialization
  // ==========================
  void init(String unitId) {
    _fakeUnitDetails = FakeDataGenerator.generateFakeUnitDetails(unitId: 1);
    fetchUnitDetails(unitId);
  }

  /// Fetches the detailed data for a specific unit.
  Future<void> fetchUnitDetails(String unitId) async {
    _isLoading = true;
    notifyListeners();

    await _cubit.unitDetails(id: unitId);
    _unitDetails = _cubit.detailsData;

    _isLoading = false;
    notifyListeners();
  }

  // ==========================
  //      Navigation
  // ==========================
  void bookNow(BuildContext context) {
    NavigationServices(context).gotoBookScreen();
  }

  void goToReviews(BuildContext context) {
    NavigationServices(context).gotoReviewsListScreen();
  }
}