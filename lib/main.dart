import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_udmy/provider.dart';
import 'package:riverpod_udmy/view_model.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

///riverpodをMyApp以下で使えるように宣言している。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  ViewModel viewModel = ViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.setRef(ref);
    /*ここでrefを呼び出したので、65行目のref.watch(countDataProvider).count.toString(),
    をviewModel.countでアクセスできるようになる,
    (このやり方はConsumerStatefulWidgetを使用している時のみ可能)
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ref.watch(titleProvider),

            /*Consumer(
        builder: (context, ref, child) => Text(ref.watch(titleProvider)
           ),
          ),この書き方でも受け取り可能(この方がwidgetの構築数を制限できる為、パフォーマンスは上がる)*/
            ///ref.watchでproviderの中身を監視している
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ref.watch(messageProvider),
              ),
              Text(
                viewModel.count.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      viewModel.onIncrease();
                    },
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      viewModel.onDecrease();
                    },
                    child: Icon(CupertinoIcons.minus),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text(viewModel.countUp), Text(viewModel.countDown)],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.oneReset();
          },

          ///状態の変更を行う時はnotifier.stateを追加でつけてあげた
          tooltip: 'Increment',
          child: Icon(Icons.refresh),
        ));
  }
}
