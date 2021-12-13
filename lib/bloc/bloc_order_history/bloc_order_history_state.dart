part of 'bloc_order_history_cubit.dart';

abstract class BlocOrderHistoryState extends Equatable {
  const BlocOrderHistoryState();
  @override
  List<Object> get props => [];
}

class BlocOrderHistoryInitial extends BlocOrderHistoryState {}

class BlocOrderHistoryLoadingState extends BlocOrderHistoryState {}

class BlocOrderHistorySuccessState extends BlocOrderHistoryState {
  final AllOrdersHistoryModel allOrdersHistoryModel;

  const BlocOrderHistorySuccessState(this.allOrdersHistoryModel);

}

class BlocOrderHistoryFailedState extends BlocOrderHistoryState {}
