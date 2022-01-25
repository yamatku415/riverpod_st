import 'package:riverpod_udmy/data/count_data.dart';

//MVVMの「model」
class Logic {
  CountData countData = CountData(count: 0, countUp: 0, countDown: 0);
  void increase() {
    countData = countData.copyWith(
        count: countData.count + 1, countUp: countData.countUp + 1);
  }

  void decrease() {
    countData = countData.copyWith(
        count: countData.count - 1, countDown: countData.countDown + 1);
  }

  void reset() {
    countData = CountData(count: 0, countUp: 0, countDown: 0);
  }
}
