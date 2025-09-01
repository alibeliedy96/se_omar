import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mr_omar/utils/base_cubit/base_pagination_response.dart';
import 'package:mr_omar/utils/help_me.dart';
import '../../../../utils/base_cubit/base_cubit.dart';
import '../../../../utils/fake_data_generator.dart';
import '../../domain/models/search_response.dart';
import '../../logic/search_cubit/search_cubit.dart';


class SearchListController extends ChangeNotifier {
  // ==========================
  //      Dependencies
  // ==========================
  final SearchCubit _cubit = SearchCubit.get();

  // ==========================
  //      State Variables
  // ==========================


  // ==========================
  //      Public Getters
  // ==========================
   TextEditingController searchController=TextEditingController();
  bool _isLoading = true;
  late List<SearchData> _fakeSearch;
  // The View reads the reservations list directly from the cubit
  List<SearchData> get reservations => _isLoading ? _fakeSearch :_cubit.searchList;

  // A helper getter to check if it's the last page for the refresher
  bool get isLastPage => _cubit.paginationOf(SearchApiTypes.search).getIsLastPage();

  // ==========================
  //      Initialization
  // ==========================
  void init({required String searchKey}) {
    printLog("searchKey $searchKey");
    searchController.text=searchKey;
    _fakeSearch = FakeDataGenerator.generateFakeSearchResponse();
    // Fetch the first page of reservations when the screen is initialized.
    onRefresh();
  }

  // ==========================
  //      Public Methods (UI Actions)
  // ==========================

  /// Handles the pull-to-refresh action.
  Future<void> onRefresh( ) async {
    _isLoading = true;
    notifyListeners();

    await _cubit.search(paginationMethod: PaginationMethod.refresh,searchKey: searchController.text);


    _isLoading = false;


    notifyListeners();
  }

  /// Handles the load-more action when scrolling to the bottom.
  Future<void> onLoadMore( ) async {
    await _cubit.search(paginationMethod: PaginationMethod.loadMore,searchKey: searchController.text);

    notifyListeners();
  }

  // ==========================
  //      fake data
  // ==========================





}