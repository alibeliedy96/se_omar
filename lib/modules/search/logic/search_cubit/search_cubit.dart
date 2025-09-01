import '../../../../../../core/get_it/get_it.dart';
import '../../../../utils/base_cubit/base_cubit.dart';

import '../../domain/models/search_response.dart';
import '../../domain/services/search_service.dart';


enum SearchApiTypes {  loadInitialData,  search,  }

class SearchCubit extends BaseCubit<SearchApiTypes>   {
  final SearchService  repo;
  SearchCubit({required this.repo}): super(SearchApiTypes.loadInitialData);
  static SearchCubit get() => getIt<SearchCubit>();

  /// search
  List<SearchData> _searchList= [];


  List<SearchData> get  searchList => _searchList;

  Future search({required PaginationMethod paginationMethod,required String searchKey }) async {
    return await fastPagination<SearchResponse>(
        type:  SearchApiTypes.search,
        fun: (int page) =>  repo.search(page: page,searchKey:searchKey),
        onRefreshSuccess: (r) => _searchList = r.data??[],
        onLoadMoreSuccess: (r) => _searchList.addAll(r.data??[]),
        toMeta: (r) => r.pagination,

        paginationMethod: paginationMethod);
  }

}


