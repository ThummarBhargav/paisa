import 'package:injectable/injectable.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/account/data/data_sources/local/account_data_manager.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@Singleton(as: AccountRepository)
class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({required this.dataSource});

  final LocalAccountManager dataSource;

  @override
  Future<void> addAccount({
    required String bankName,
    required String holderName,
    required String number,
    required CardType cardType,
    required double amount,
    required int color,
    required bool isAccountExcluded,
  }) {
    return dataSource.add(AccountModel(
      name: holderName,
      bankName: bankName,
      number: number,
      cardType: cardType,
      amount: amount,
      color: color,
      isAccountExcluded: isAccountExcluded,
    ));
  }

  @override
  Future<void> clearAll() {
    return dataSource.clear();
  }

  @override
  Future<void> deleteAccount(int key) {
    return dataSource.delete(key);
  }

  @override
  AccountModel? fetchAccountFromId(int? accountId) {
    return dataSource.findById(accountId);
  }

  @override
  List<AccountModel> getAccounts() {
    return dataSource.accounts();
  }

  @override
  Future<void> updateAccount({
    required int key,
    required String? bankName,
    required String? holderName,
    required String? number,
    required CardType? cardType,
    required double? amount,
    required int? color,
    required bool isAccountExcluded,
  }) {
    return dataSource.update(
      AccountModel(
        name: holderName,
        bankName: bankName,
        number: number,
        cardType: cardType,
        amount: amount,
        superId: key,
        color: color,
        isAccountExcluded: isAccountExcluded,
      ),
    );
  }
}
