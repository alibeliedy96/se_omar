//  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../core/get_it/get_it.dart';
// import 'base_cubit.dart';
//
//
// class BlockBuilderWidget<Cubit extends BaseCubit<S>, S> extends StatelessWidget {
//   final List<S> types;
//   final Widget Function(S currentApi) body;
//   final Widget Function(S currentApi)? loading;
//   final Widget Function(S currentApi)? error;
//   final Widget Function(S currentApi)? fetchMore;
//
//   /// >> if only body this will ignore other cases
//   final bool showOnlyBodyInAllCases;
//
//   const BlockBuilderWidget({
//     super.key,
//     required this.body,
//     this.loading,
//     this.error,
//     required this.types,
//     this.fetchMore,
//     this.showOnlyBodyInAllCases = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Cubit? cubit;
//     if (getIt.isRegistered<Cubit>()) cubit = getIt.get<Cubit>();
//     if (cubit == null) print("logic == null  logic($Cubit)");
//
//     return useProvider(
//       useIt: cubit != null,
//       child: BlocBuilder<Cubit, BaseState>(
//         buildWhen: (p, c) => types.contains(c.type),
//         builder: (context, state) {
//           var type = state.type;
//           if (!types.contains(type)) type = types.firstOrNull;
//           BaseCubit cubit = context.read<Cubit>();
//           var currentState = cubit.stateOf(type);
//           // log("builder context.read<$Cubit>().stateOf($type) : $currentState", level: 1);
//           if (showOnlyBodyInAllCases) return body(type); // if only body this will ignore other cases
//           if (currentState.isDone()) return body(type);
//           if (currentState.isLoading()) return loading != null ? loading!(type) : const SizedBox();
//           if (currentState.isError()) return error != null ? error!(type) : const SizedBox();
//           if (currentState.isPaginationLoadMore()) return fetchMore != null ? fetchMore!(type) : body(type);
//           return const SizedBox();
//         },
//       ),
//     );
//   }
//
//   Widget useProvider({required Widget child, required bool useIt}) {
//     if (!useIt) return child;
//     return BlocProvider.value(
//       value: getIt<Cubit>(),
//       child: child,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_omar/utils/help_me.dart';

import '../../core/get_it/get_it.dart';
import 'base_cubit.dart';


class BlockBuilderWidget<Cubit extends BaseCubit<S>, S> extends StatefulWidget {
  final List<S> types;
  final Widget Function(S currentApi) body;
  final Widget Function(S currentApi)? loading;
  final Widget Function(S currentApi)? error;
  final Widget Function(S currentApi)? fetchMore;
  final bool showOnlyBodyInAllCases;


  final bool disposeCubitAfterUse;

  const BlockBuilderWidget({
    super.key,
    required this.body,
    this.loading,
    this.error,
    required this.types,
    this.fetchMore,
    this.showOnlyBodyInAllCases = false,
    this.disposeCubitAfterUse = false,
  });

  @override
  State<BlockBuilderWidget<Cubit, S>> createState() => _BlockBuilderWidgetState<Cubit, S>();
}

class _BlockBuilderWidgetState<Cubit extends BaseCubit<S>, S> extends State<BlockBuilderWidget<Cubit, S>> {
  Cubit? cubit;

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<Cubit>()) {
      cubit = getIt.get<Cubit>();
    }
    if (cubit == null) {
      print("Cubit not found in GetIt: $Cubit");
    }
  }


  @override
  void dispose() {

    if (widget.disposeCubitAfterUse && getIt.isRegistered<Cubit>()) {
      printLog("Disposing and unregistering Cubit: $Cubit");
      getIt.unregister<Cubit>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cubit == null) {
      // Handle the case where the cubit is not found, maybe it was disposed.
      return widget.error != null ? widget.error!(widget.types.first) : const SizedBox();
    }

    return BlocProvider.value(
      value: cubit!,
      child: BlocBuilder<Cubit, BaseState>(
        buildWhen: (p, c) => widget.types.contains(c.type),
        builder: (context, state) {
          var type = state.type;
          if (!widget.types.contains(type)) type = widget.types.first;
          var currentState = cubit!.stateOf(type);

          if (widget.showOnlyBodyInAllCases) return widget.body(type);
          if (currentState.isDone()) return widget.body(type);
          if (currentState.isLoading()) return widget.loading != null ? widget.loading!(type) : const SizedBox();
          if (currentState.isError()) return widget.error != null ? widget.error!(type) : const SizedBox();
          if (currentState.isPaginationLoadMore()) return widget.fetchMore != null ? widget.fetchMore!(type) : widget.body(type);

          // Default fallback
          return widget.body(type);
        },
      ),
    );
  }
}