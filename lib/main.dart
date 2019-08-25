import 'package:flutter/material.dart';
import 'dart:async';

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

  String _text = 'Hello World!!!';
  bool _checkbox = false;
  int _sum = 0;
  String _submitText = '';
  bool _combo = false;
  int _radio1 = 0;
  double _slider = 0.0;
  String _date = '';
  String _fab = '';
  String _appBarTitle = 'Flutter! ';

  List<BottomNavigationBarItem> _items;
  int _bottomNavIndex = 0;

  @override
  void initState() {
    _items = new List();
    _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.people), title: new Text('People')));
    _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.weekend), title: new Text('Weekend')));
    _items.add(new BottomNavigationBarItem(icon: new Icon(Icons.message), title: new Text('Message')));
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2015),
      lastDate: new DateTime(2020)
    );
    if (picked != null) {
      setState(() {
       _date = picked.toString(); 
      });
    }
  }

  void _onCLickFAB() {
    setState(() {
      DateTime dateTime = new DateTime.now();
      _fab = dateTime.second.toString();
    });
  }

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
        title: new Text(_appBarTitle + ' ' + _sum.toString() + ' ' + _fab + ' ' + _bottomNavIndex.toString()),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: _add),
          new IconButton(icon: new Icon(Icons.remove), onPressed: _subtract)
        ],
      ),
      persistentFooterButtons: <Widget>[
          new IconButton(icon: new Icon(Icons.add),  onPressed: _add),
          new IconButton(icon: new Icon(Icons.remove), onPressed: _subtract)
      ],
      floatingActionButton: new FloatingActionButton(
        onPressed: _onCLickFAB,
        backgroundColor: Colors.blue,
        mini: true, 
        child: new Icon(Icons.timer),
      ),
      drawer: new Drawer(
        child: new Container(
          padding: new EdgeInsets.all(32.00), 
          child: new Column(
            children: <Widget>[
              new Text('Menu'), 
              new RaisedButton(onPressed: () => Navigator.pop(context), child: new Text('Close Menu'))
      ],),),),
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

              // example of DatePicker
              new Text('DatePicker Value: ' + _date),
              new RaisedButton(onPressed: () =>  _selectDate(), child: new Text('Select a date'),),
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
    ),
    bottomNavigationBar: new BottomNavigationBar(
      items: _items, 
      fixedColor: Colors.blue, 
      currentIndex: _bottomNavIndex,
      onTap: (int item) {
        setState(() {
          _bottomNavIndex = item;
        });
    },),
  );
  }
}
