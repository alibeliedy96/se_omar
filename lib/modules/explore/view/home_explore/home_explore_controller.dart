// File: home_explore_controller.dart

import 'package:flutter/material.dart';
import 'package:mr_omar/routes/route_names.dart';
import '../../../../utils/fake_data_generator.dart';
import '../../domain/models/slider_response.dart';
import '../../domain/models/units_response.dart';
import '../../logic/explore_cubit/explore_cubit.dart';


class HomeExploreController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ExploreCubit _cubit = ExploreCubit.get();

  // ==========================
  //      State Variables
  // ==========================
  bool _isLoading = true;
  late List<SliderData> _fakeSliders;
  late List<UnitsData> _fakeUnits;
  // ==========================
  //      Public Getters
  // ==========================
  bool get isLoading => _isLoading;
  List<SliderData> get sliders => _isLoading ? _fakeSliders : (_cubit.slider);
  List<UnitsData> get units => _isLoading ? _fakeUnits : (_cubit.units);

  // ==========================
  //      Initialization
  // ==========================
  HomeExploreController() {
    init();
  }

  void init() {
    _fakeSliders = FakeDataGenerator.generateFakeSliders();
    _fakeUnits = FakeDataGenerator.generateFakeUnits();
    fetchData();

  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    await _cubit.loadInitialData();

    _isLoading = false;
    notifyListeners();
  }

  // ==========================
  //      Navigation
  // ==========================
  void navigateToSearch(BuildContext context,{required String searchKey}) {
    NavigationServices(context).gotoSearchScreen(searchKey:searchKey);
  }

  void navigateToUnitDetails(BuildContext context, UnitsData unit) {
    // Assuming you have a route for unit details
     NavigationServices(context).gotoHotelDetails(unitId: unit.id.toString());
  }
}