//cryptoCurrency class to store if crypto is followed by user --> this is that to store into SharedPreference
class CryptoCurrency {
  String name;
  bool isFollowed;

  CryptoCurrency(this.name, this.isFollowed);

  @override
  String toString() => 'Crypto name : ${this.name} is followed ? : ${this.isFollowed}';
}
