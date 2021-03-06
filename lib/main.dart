import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_provider/counterapp/counter_bloc.dart';
import 'package:learning_provider/counterapp/counter_page.dart';
import 'package:learning_provider/remote_bloc.dart';
import 'package:learning_provider/remote_event.dart';
import 'package:learning_provider/remote_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
            create: (context) => CounterBloc(), child: CounterApp()),
      ),
    );
  }
}

class GrandWidget extends StatefulWidget {
  @override
  _GrandWidgetState createState() => _GrandWidgetState();
}

class _GrandWidgetState extends State<GrandWidget> {
  @override
  Widget build(BuildContext context) {
    print("==> Grand Widget");
    return FutureBuilder(
      future: getRandomInt(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          print((snapshot.data as DataProvider)._counter);
          child = Container(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [DaddyWidget()],
            )),
          );
        } else if (snapshot.hasError) {
          child = Column(
            children: [Text("ERROR")],
          );
        } else {
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Waiting for Data"),
                CircularProgressIndicator(
                  backgroundColor: Colors.red,
                )
              ],
            ),
          );
        }
        return child;
      },
    );
  }

  Future<DataProvider> getRandomInt() async {
    return Future.delayed(Duration(seconds: 5), () {
      return new DataProvider();
    });
  }
}

class DaddyWidget extends StatelessWidget {
  final String data = "Nguyen cao Thiem";
  @override
  Widget build(BuildContext context) {
    print("==> Daddy");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Son2(),
        SubSon2(),
      ],
    );
  }
}

class Son1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("==> Son1");
    return Container(
      child: new RaisedButton(
        onPressed: () =>
            Provider.of<DataProvider>(context, listen: false).increment(),
        child: Text(Provider.of<DataProvider>(context)._counter.toString()),
      ),
    );
  }
}

class Son2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("==> Son2");
    print(MediaQuery.of(context).size);
    return Container(
      width: MediaQuery.of(context).size.width,
      // child: Text(context.watch<DataProvider>()._counter.toString()),
      child: Text(
          Provider.of<DataProvider>(context, listen: true)._counter.toString()),
    );
  }
}

class SubSon2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("==> SubSon2");
    return Column(
      children: [
        // Text(Provider.of<DataProvider>(context)._counter.toString()),
        Container(
          child: Son1(),
        ),
      ],
    );
  }
}

class DataProvider with ChangeNotifier {
  int _counter = 0;
  get counter => _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }
}

class TextBloc extends StatefulWidget {
  @override
  _TextBlocState createState() => _TextBlocState();
}

class _TextBlocState extends State<TextBloc> {
  final remoteBloc = RemoteBloc();
  @override
  Widget build(BuildContext context) {
    print("==> render scaffold");
    return Scaffold(
      body: StreamBuilder(
          initialData: remoteBloc.state,
          stream: remoteBloc.stateController.stream,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            print("==> render build context");
            return Center(
                child: Text(
              "Current volumns is: ${snapshot.data.volumn}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ));
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              remoteBloc.eventController.sink.add(IncreaseVolumn(2));
            },
            child: Text("+"),
          ),
          FloatingActionButton(
            onPressed: () {
              remoteBloc.eventController.sink.add(DecreaseVolumn(2));
            },
            child: Text("-"),
          ),
          FloatingActionButton(
            onPressed: () {
              remoteBloc.eventController.sink.add(MuteVolumn());
            },
            child: Text("Mute"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.remoteBloc.dispose();
  }
}
