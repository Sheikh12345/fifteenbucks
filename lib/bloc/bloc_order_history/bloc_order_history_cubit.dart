import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fifteenbucks/model/all_orders_history_model.dart';
import 'package:fifteenbucks/server_interaction/my_orders_history_api.dart';

part 'bloc_order_history_state.dart';

class BlocOrderHistoryCubit extends Cubit<BlocOrderHistoryState> {
  BlocOrderHistoryCubit() : super(BlocOrderHistoryInitial());

  getOrderHistory() async {
    emit(BlocOrderHistoryLoadingState());
    final AllOrdersHistoryModel allOrdersHistoryModel =
        await GetHistoryApi().getOrdersList();

    if (allOrdersHistoryModel.success ?? false) {
      emit(BlocOrderHistorySuccessState(allOrdersHistoryModel));
    } else {
      emit(BlocOrderHistoryFailedState());
    }
  }
}
