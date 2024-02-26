part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent extends Equatable {
  AccountsEvent();

  @override
  List<Object> get props => [];
}

class AddOrUpdateAccountEvent extends AccountsEvent {
  AddOrUpdateAccountEvent(this.isAdding);

  final bool isAdding;
}

class DeleteAccountEvent extends AccountsEvent {
  DeleteAccountEvent(this.accountId);

  final String accountId;

  @override
  List<Object> get props => [accountId];
}

class FetchAccountAndExpenseFromIdEvent extends AccountsEvent {
  FetchAccountAndExpenseFromIdEvent(this.accountId);

  final String accountId;

  @override
  List<Object> get props => [accountId];
}

class AccountSelectedEvent extends AccountsEvent {
  AccountSelectedEvent(this.account);

  final AccountEntity account;

  @override
  List<Object> get props => [account];
}

class FetchAccountFromIdEvent extends AccountsEvent {
  FetchAccountFromIdEvent(this.accountId);

  final String? accountId;

  @override
  List<Object> get props => [accountId ?? ''];
}

class UpdateCardTypeEvent extends AccountsEvent {
  final CardType cardType;
  UpdateCardTypeEvent(this.cardType);

  @override
  List<Object> get props => [cardType];
}

class FetchExpensesFromAccountIdEvent extends AccountsEvent {
  final String accountId;
  FetchExpensesFromAccountIdEvent(this.accountId);

  @override
  List<Object> get props => [accountId];
}

class AccountColorSelectedEvent extends AccountsEvent {
  final int accountColor;
  AccountColorSelectedEvent(this.accountColor);

  @override
  List<Object> get props => [accountColor];
}