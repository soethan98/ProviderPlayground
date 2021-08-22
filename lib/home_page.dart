import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/counter.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    /*without listen parameter,if the value change provider rebuilt 
  the whole widget under the specified context*/

    //When make listen to false,we have to use cosumer widget for needed widget to change
    // final counter = Provider.of<Counter>(context, listen: false);

    final counter = Provider.of<ValueNotifier<int>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Text('You have pushed the button this many times:'),
            // Consumer<Counter>(builder: (context, c, child) {
            //   return Text(
            //     '${c.count}',
            //     style: Theme.of(context).textTheme.headline6,
            //   );
            // }),
            Consumer<ValueNotifier<int>>(builder: (context, c, child) {
              return Text(
                '${c.value}',
                style: Theme.of(context).textTheme.headline6,
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        child: Icon(Icons.add),
      ),
    );
  }
}
