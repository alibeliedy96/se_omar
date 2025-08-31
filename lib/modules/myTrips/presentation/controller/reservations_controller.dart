import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mr_omar/utils/base_cubit/base_pagination_response.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/fake_data_generator.dart';
import '../../domain/models/get_reservations_response.dart';
import '../../logic/reservations_cubit/reservations_cubit.dart';


class ReservationsController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final ReservationsCubit _cubit = ReservationsCubit.get();

  // ==========================
  //      State Variables
  // ==========================


  // ==========================
  //      Public Getters
  // ==========================
  bool _isLoading = true;
  late List<ReservationsData> _fakeReservations;
  // The View reads the reservations list directly from the cubit
  List<ReservationsData> get reservations => _isLoading ? _fakeReservations :_cubit.reservations;

  // A helper getter to check if it's the last page for the refresher
  bool get isLastPage => _cubit.paginationOf(ReservationsApiTypes.reservations).getIsLastPage();

  // ==========================
  //      Initialization
  // ==========================
  void init({required String status}) {
    _fakeReservations = FakeDataGenerator.generateFakeReservationsResponse();
    // Fetch the first page of reservations when the screen is initialized.
    onRefresh(status: status);
  }

  // ==========================
  //      Public Methods (UI Actions)
  // ==========================

  /// Handles the pull-to-refresh action.
  Future<void> onRefresh({required String status}) async {
    _isLoading = true;
    notifyListeners();

    await _cubit.getReservations(paginationMethod: PaginationMethod.refresh,status: status);


    _isLoading = false;


    notifyListeners();
  }

  /// Handles the load-more action when scrolling to the bottom.
  Future<void> onLoadMore({required String status}) async {
    await _cubit.getReservations(paginationMethod: PaginationMethod.loadMore,status: status);

    notifyListeners();
  }

  // ==========================
  //      fake data
  // ==========================





}