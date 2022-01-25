import 'package:riverpod/riverpod.dart';
import 'package:riverpod_udmy/data/count_data.dart';

final titleProvider = Provider<String>((ref) {
  return 'Flutter riverpod';
});

final messageProvider = Provider<String>((ref) {
  return 'You have pushed the button this many times:';
});

///refを介して値を渡す
///このやりかただと値が定数のようになる。(ホットリスタートをしないと値が変更されない)

final countProvider = StateProvider<int>((ref) => 0);

///状態を保存するしながら

final countDataProvider = StateProvider<CountData>(
    (ref) => CountData(count: 0, countUp: 0, countDown: 0));
