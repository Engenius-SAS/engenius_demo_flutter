import 'package:flutter/material.dart';
import 'package:engenius/engenius.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEMO package Engenius',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DEMO Engenius'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "false";
  var _idcard = "";
  var _valorP = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

   Future<void> habilitar() async {
    var _flag = await Engenius.habilitar;
    setState(() {
      _counter = _flag.toString();
    });
  }

 void leerEnviar() async{
    var result = await Engenius.LeerEnviar();
      if(result[0] == "ERR") {
        setState(() {
          _counter = "USUARIO NO REGISTRADO EN LA PLATAFORMA";
        });
      } else {
        setState(() {
        _counter = "Usuario: " +
          result[0].toString() +
          '\r\n' +
          "Documento: " +
          result[1].toString() +
          '\r\n' +
          "Tipo Instalación: " +
          result[2].toString() +
          '\r\n' +
          "Ultima Recarga: " +
          result[3].toString() +
          '\r\n' +
          "Valor a Pagar: " +
          result[4].toString() +
          '\r\n' +
           "Id Card: " +
          result[5].toString() +
          '\r\n';
        });
        _idcard = result[5];
        _valorP = int.parse(result[4]);
      }
    
  }

  Future<void> Recargar() async {
    var _flag = await Engenius.recargar(_idcard,_valorP,"123456789","Desarrollador");
    setState(() {
      _counter = _flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text('1. Habilitar Escucha de Tarjeta',
                    style:
                        TextStyle(color: Colors.white, fontSize: 12.0)),
                onPressed: habilitar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text('2. Leer y Enviar',
                    style:
                        TextStyle(color: Colors.white, fontSize: 12.0)),
                onPressed: leerEnviar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text('3. Recargar',
                    style:
                        TextStyle(color: Colors.white, fontSize: 12.0)),
                onPressed: Recargar,
              ),
            ),
            Text(
              'Mensaje:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
