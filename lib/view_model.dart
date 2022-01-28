import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_udmy/logic/logic.dart';
import 'package:riverpod_udmy/provider.dart';

import 'logic/sound_logic.dart';

class ViewModel {
  Logic logic = Logic();

  SoundLogic soundLogic = SoundLogic();

  late WidgetRef
      ref; //refを使うことが明らかなので先にrefを定義してある(reverpodのprovifderに簡単にアクセス出来るになる)

  void setRef(WidgetRef ref) {
    this.ref = ref;
    soundLogic.load();
  }

  get count => ref.watch(countDataProvider).count.toString();
  get countUp => ref
      .watch(countDataProvider.select((value) => value.countUp))
      .toString(); //.select((value) => value.countUp))を追加するとwidgetの再構築がされなくなる(抑えられる)
  get countDown => ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    logic.increase();
    ref.watch(countDataProvider.notifier).state = logic.countData;
    soundLogic.playUpSound();
  }

  void onDecrease() {
    logic.decrease();
    ref.watch(countDataProvider.notifier).state = logic.countData;
    soundLogic.playDownSound();
  }

  void oneReset() {
    logic.reset();
    ref.watch(countDataProvider.notifier).state = logic.countData;
    soundLogic.playResetSound();
  }
}
