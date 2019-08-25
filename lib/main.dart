import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp()
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  @override

  String _text = 'Hello World!!!';
  bool _checkbox = false;
  int _sum = 0;
  String _submitText = '';
  bool _combo = false;
  int _radio1 = 0;
  double _slider = 0.0;

  void _onChangeRadio(int value) {
    setState(() {
      _radio1 = value;
    });
  }

  void _onChangeSlider(double value) {
    setState(() {
      _slider = value;
    });
  }

  void _onComboChanged(bool value) {
    setState(() => _combo = value);
  }

  void _onCheckboxChanged(bool value) {
    setState(() => _checkbox = value);
  }

  void _add() {
    setState(() {
      _sum++;
    });
  }

  void _subtract() {
    setState(() {
      _sum--;
    });
  }

  void _onPressed(String v) {
    setState(() {
      _text = v + ' ' + new DateTime.now().toString();
    });
  }

  void _onChangeText(String value) {
    setState(() => _submitText = '${value}');
  }
  
  void _onSubmitText(String value) {
    setState(() => _submitText = 'Submitted: ${value}');
  }

  Widget makeDivider() {
    Divider divider = new Divider(
      color: Colors.indigo
    );
    
    EdgeInsets edgeInsets = new EdgeInsets.all(5.0);
    
    Container container = new Container(
      padding: edgeInsets,
      child: divider
    );
    
    return container;
  }

  Widget makeRadios() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
        new RadioListTile(
          value: i, 
          groupValue: _radio1, 
          onChanged: _onChangeRadio, 
          activeColor: Colors.greenAccent,
          title: new Text('Item ${i}'),
          subtitle: new Text('sub title ${i}'),
          )
      );
    }
    Column column = new Column(children: list);
    return column;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Name here")
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              
              // plain ol text and example callbacks onPressed
              new Text(_text),
              new Row(children: <Widget>[
                  new RaisedButton(onPressed: () =>  _onPressed('1'), child: new Text('Click me'),),
                  new FlatButton(onPressed: () => _onPressed('2'), child: new Text('Click me'),),
              ],),
              makeDivider(),

              // another example of callbacks on press of IconButton
              new Text(_sum.toString()),
              new Row(children: <Widget>[
                new IconButton(icon: new Icon(Icons.add), onPressed: _add),
                new IconButton(icon: new Icon(Icons.remove), onPressed: _subtract),
              ]),
              makeDivider(),

              // example of TextField
              new Text(_submitText),
              new TextField(
                decoration: new InputDecoration( labelText: 'Type some text here:', hintText: 'Some text', icon: new Icon(Icons.people) ),
                autocorrect: true, 
                autofocus: true,
                keyboardType: TextInputType.text,
                onChanged: _onChangeText, 
                onSubmitted: _onSubmitText,
              ),
              makeDivider(),

              // example of CheckBox
              // new Checkbox(value: _checkbox, onChanged: _onCheckboxChanged),
              new CheckboxListTile(value: _checkbox, onChanged: _onCheckboxChanged, title: new Text('Checkbox'), secondary: new Icon(Icons.archive), activeColor: Colors.red,),
              makeDivider(),

                // example of Slider
              new Text('Slider Value: ${(_slider * 100).round()}'),
              new Slider(value: _slider, onChanged: _onChangeSlider),
              makeDivider(),

              // example of Radios - note a function is returning the widget that is generated dynamically
              makeRadios(),
              makeDivider(),

              // example of combo
              new SwitchListTile(
                  value: _combo,
                  onChanged: _onComboChanged,
                  title: new Text('Combo Example')
              ),
              makeDivider(),

          ]
        )
      )
    )
  );
  }
}
