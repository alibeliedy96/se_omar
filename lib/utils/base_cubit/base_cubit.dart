import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

 import '../../core/api/error/error_handler/failure.dart';
import 'base_pagination_response.dart';

enum StateType { loading, done, error, loadMore }

enum PaginationMethod { refresh, loadMore }

typedef BaseEitherResponse<T> = Future<Either<Failure, T>>;

class BaseCubit<StatesEnum> extends Cubit<BaseState<StatesEnum>> {
  BaseCubit(StatesEnum currentState) : super(BaseState(currentState)) {
    init();
  }

  //
  //
  // يسطا لو انت داخل تعدل حاجة هنا يبقي انت ماشي غلط
  // 😡يسطا سيب الملف في حاله يسطا انت عايز اي بس😡
  //
  //                                 .,od88888888888bo,.
  //                             .d88888888888888888888888b.
  //                          .d88888888888888888888888888888b.
  //                        .d888888888888888888888888888888888b.
  //                      .d8888888888888888888888888888888888888b.
  //                     d88888888888888888888888888888888888888888b
  //                    d8888888888888888888888888888888888888888888b
  //                   d888888888888888888888888888888888888888888888
  //                   8888888888888888888888888888888888888888888888
  //                   8888888888888888888888888888888888888888888888
  //                   8888888888888888888888888888888888888888888888
  //                   Y88888888888888888888888888888888888888888888P
  //                   "8888888888P'   "Y8888888888P"    "Y888888888"
  //                    88888888P        Y88888888P        Y88888888
  //                    Y8888888          ]888888P          8888888P
  //                     Y888888          d888888b          888888P
  //                      Y88888b        d88888888b        d88888P
  //                       Y888888b.   .d88888888888b.   .d888888
  //                        Y8888888888888888P Y8888888888888888
  //                         888888888888888P   Y88888888888888
  //                         "8888888888888[     ]888888888888"
  //                            "Y888888888888888888888888P"
  //                                 "Y88888888888888P"
  //                              888b  Y8888888888P  d888
  //                              "888b              d888"
  //                               Y888bo.        .od888P
  //                                Y888888888888888888P
  //                                 "Y88888888888888P"
  //                                   "Y8888888888P"
  //           d8888bo.                  "Y888888P"                  .od888b
  //          888888888bo.                  """"                  .od8888888
  //          "88888888888b.                                   .od888888888[
  //          d8888888888888bo.                              .od888888888888
  //        d88888888888888888888bo.                     .od8888888888888888b
  //        ]888888888888888888888888bo.            .od8888888888888888888888b=
  //        888888888P" "Y888888888888888bo.     .od88888888888888P" "Y888888P=
  //         Y8888P"           "Y888888888888bd888888888888P"            "Y8P
  //           ""                   "Y8888888888888888P"
  //                                  .od8888888888bo.
  //                              .od888888888888888888bo.
  //                          .od8888888888P"  "Y8888888888bo.
  //                       .od8888888888P"        "Y8888888888bo.
  //                   .od88888888888P"              "Y88888888888bo.
  //         .od888888888888888888P"                    "Y8888888888888888bo.
  //        Y8888888888888888888P"                         "Y8888888888888888b=
  //        888888888888888888P"                            "Y8888888888888888=
  //         "Y888888888888888                               "Y88888888888888P=
  //              ""Y8888888P                                  "Y888888P"
  //                 "Y8888P                                     Y888P"
  //                    ""                                        """

  // ----------------------------------------------------------
  // ----------------------------------------------------------
  // ----------------------------------------------------------

  // -------------------------- init --------------------------
  void init() {}

  // -------------------------- states --------------------------
  final Map<StatesEnum, StateType> _stateMap = {}; // map contain all the states of logic

  StateType stateOf(StatesEnum state) => _stateMap[state] ?? StateType.done; // get the state of one api

  // -------------------------- voids --------------------------

  void fire(StatesEnum type, [StateType? stateType]) {
    if (stateType != null) _stateMap[type] = stateType;
    emit((BaseState(type)));
  }

  Future<Either<Failure, T>> fastFire<T>({
    required StatesEnum type,
    required Future<Either<Failure, T>> Function() fun,
    Function(Failure l)? onFailure,
    required Function(T r) onSuccess,
    bool callLoading = true,
  }) async {
    if (callLoading) fire(type, StateType.loading); // update state to loading
    var res = await fun(); // call function and wait until finished
    return res.fold(
          (l) {
        l.printInfo("fastFire<$T>"); // print error for debugging
        if (onFailure != null) onFailure(l); // call onFailure if existing
        fire(type, StateType.error); // update state to error
        return left(l); // return left with failure
      },
          (r) {
        onSuccess(r); // call onSuccess
        fire(type, StateType.done); // update state to done
        return right(r); // return right with data
      },
    );
  }

  // -------------------------- pagination --------------------------
  final Map<StatesEnum, BasePaginationResponse> _paginationMap = {};

  BasePaginationResponse paginationOf(StatesEnum state) => _paginationMap[state] ?? BasePaginationResponse();

  Future<Either<Failure, T>> fastPagination<T>({
    required StatesEnum type,
    required Future<Either<Failure, T>> Function(int page) fun,
    required Function(T r) onRefreshSuccess,
    required Function(T r) onLoadMoreSuccess,
    required BasePaginationResponse? Function(T t) toMeta,
    required PaginationMethod paginationMethod,
    Function(Failure r)? onFailure,
  }) async {
    BasePaginationResponse paginationInfo = paginationOf(type);
    // if load more check if not last page or exit
    if (paginationMethod == PaginationMethod.loadMore && paginationInfo.currentPage >= paginationInfo.lastPage) {
      return left(Failure(-1054, "", TypeMsg.ok));
    }

    if (paginationMethod == PaginationMethod.refresh) fire(type, StateType.loading); // if refresh only => update state to loading
    if (paginationMethod == PaginationMethod.loadMore) fire(type, StateType.loadMore); // if loadMore only => update state to loadMore pagination

    int nextPage = paginationMethod == PaginationMethod.refresh ? 1 : paginationInfo.currentPage + 1;
    var res = await fun(nextPage); // call function and wait until finished

    return res.fold(
          (l) {
        l.printInfo("fastPagination<$T>"); // print error for debugging
        if (onFailure != null) onFailure(l); // call onFailure if existing
        if (paginationMethod == PaginationMethod.refresh) fire(type, StateType.error); // update state to error
        if (paginationMethod == PaginationMethod.loadMore) fire(type, StateType.done); // update state to error
        return left(l); // return left with failure
      },
          (r) {
        if (toMeta(r) != null) _paginationMap[type] = toMeta(r)!;
        if (paginationMethod == PaginationMethod.refresh) onRefreshSuccess(r); // call onSuccess
        if (paginationMethod == PaginationMethod.loadMore) onLoadMoreSuccess(r); // call onSuccess
        fire(type, StateType.done); // update state to done
        return right(r); // return right with data
      },
    );
  }

  void showErrorToast(Failure l) => l.showToast();

  // -------------------------- consumer don't do any thing lol --------------------------
  void x(dynamic _) {}
}

class BaseState<StatesEnum> {
  StatesEnum type;

  BaseState(this.type);

  @override
  String toString() => 'BaseState{type: $type}';
}

extension StateTypeEX on StateType {
  bool isLoading() => this == StateType.loading;

  bool isDone() => this == StateType.done;

  bool isError() => this == StateType.error;

  bool isPaginationLoadMore() => this == StateType.loadMore;
}
