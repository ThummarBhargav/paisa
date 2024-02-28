part of 'accounts_bloc.dart';

@immutable
abstract class AccountState extends Equatable {
  AccountState();
  @override
  List<Object> get props => [];
}

class AccountsInitial extends AccountState {}

class AccountListState extends AccountState {
  AccountListState(this.accounts);
  final List<AccountEntity> accounts;

  @override
  List<Object> get props => [accounts];
}

class AccountAddedState extends AccountState {
  AccountAddedState({this.isAddOrUpdate = false});
  final bool isAddOrUpdate;

  @override
  List<Object> get props => [isAddOrUpdate];
}

class AccountDeletedState extends AccountState {}

class AccountSelectedState extends AccountState {
  AccountSelectedState(this.account, this.expenses);
  final AccountEntity account;
  final List<TransactionEntity> expenses;

  @override
  List<Object> get props => [account, expenses];
}

class AccountErrorState extends AccountState {
  AccountErrorState(this.errorString);
  final String errorString;

  @override
  List<Object> get props => [errorString];
}

class AccountSuccessState extends AccountState {
  AccountSuccessState(this.account);
  final AccountEntity account;

  @override
  List<Object> get props => [account];
}

class UpdateCardTypeState extends AccountState {
  UpdateCardTypeState(this.cardType);
  final CardType cardType;

  @override
  List<Object> get props => [cardType];
}

class ExpensesFromAccountIdState extends AccountState {
  ExpensesFromAccountIdState(this.expenses);
  final List<TransactionEntity> expenses;

  @override
  List<Object> get props => [expenses];
}

class AccountColorSelectedState extends AccountState {
  AccountColorSelectedState(this.categoryColor);
  final int categoryColor;

  @override
  List<Object> get props => [categoryColor, identityHashCode(this)];
}

class AccountAndExpensesState extends AccountState {
  final AccountEntity account;
  final List<TransactionEntity> expenses;
  AccountAndExpensesState(this.account, this.expenses);
  @override
  List<Object> get props => [account, expenses];
}