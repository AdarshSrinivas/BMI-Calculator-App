import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({required this.title, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map bmi = {
    'Gender': '?',
    'Age': 0,
    'Weight': 0,
    'Height': 0,
    'Result': 'BMI',
    'Message': 'Fill the cards and press calculate.',
    'BMI': 0,
  };

  Map<String, Color> colors = {
    'Underweight': Color(0xff0d5c63),
    'Normal': Color(0xff0d5c63),
    'Overweight': Color(0xff0d5c63),
    'Obese': Color(0xff0d5c63),
  };

  void refresh() {
    showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).primaryColor,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              ),
              const SizedBox(height: 40),
              Text(
                'Resetting',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    }).then((value) {
      setState(() {
        bmi = {
          'Gender': '?',
          'Age': 0,
          'Weight': 0,
          'Height': 0,
          'Result': 'BMI',
          'Message': 'Fill the cards and press calculate.',
          'BMI': 0,
        };
        colors = {
          'Underweight': Color(0xff0d5c63),
          'Normal': Color(0xff0d5c63),
          'Overweight': Color(0xff0d5c63),
          'Obese': Color(0xff0d5c63),
        };
      });
    });
  }

  void changeColor() {
    colors = {
      'Underweight': Color(0xff0d5c63),
      'Normal': Color(0xff0d5c63),
      'Overweight': Color(0xff0d5c63),
      'Obese': Color(0xff0d5c63),
    };
  }

  void calculateBmi() {
    changeColor();
    double tempBmi;
    tempBmi = (bmi['Weight'] * 100 * 100) / (bmi['Height'] * bmi['Height']);
    bmi['BMI'] = double.parse(tempBmi.toStringAsFixed(2));
    if (bmi['BMI'] <= 18.49) {
      bmi['Result'] = 'UNDERWEIGHT BMI';
      bmi['Message'] = 'You will regret overeating.';
      colors['Underweight'] = Color(0xffffd166);
    } else if (bmi['BMI'] >= 18.5 && bmi['BMI'] <= 24.99) {
      bmi['Result'] = 'NORMAL BMI';
      bmi['Message'] = 'Continue your healthy lifestyle.';
      colors['Normal'] = Color(0xffffd166);
    } else if (bmi['BMI'] >= 25 && bmi['BMI'] <= 29.99) {
      bmi['Result'] = 'OVERWEIGHT BMI';
      bmi['Message'] = 'Won\'t quit til I\'m fit.';
      colors['Overweight'] = Color(0xffffd166);
    } else {
      bmi['Result'] = 'OBESE BMI';
      bmi['Message'] = 'Won\'t quit til I\'m fit.';
      colors['Obese'] = Color(0xffffd166);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0.0,
            title: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Theme.of(context).accentColor,
              ),
            ),
            centerTitle: true,
            titleSpacing: 1.5,
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: Theme.of(context).iconTheme,
            leading: GestureDetector(
              onTap: () {
                themeProvider.darkTheme = !themeProvider.darkTheme;
              },
              child: themeProvider.darkTheme
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.light_mode_outlined),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  refresh();
                },
                child: SizedBox(
                  width: 50,
                  child: Icon(
                    Icons.refresh_rounded,
                  ),
                ),
              ),
            ]),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            top: 35,
          ),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).primaryColor,
                              title: Text(
                                'Gender',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Theme.of(context).accentColor,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        RadioListTile(
                                          title: Text(
                                            'Male',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          value: 'M',
                                          groupValue: bmi['Gender'],
                                          onChanged: (var val) {
                                            setState(() {
                                              bmi['Gender'] = val;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          title: Text(
                                            'Female',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          value: 'F',
                                          groupValue: bmi['Gender'],
                                          onChanged: (var val) {
                                            setState(() {
                                              bmi['Gender'] = val;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          title: Text(
                                            'Others',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          value: 'O',
                                          groupValue: bmi['Gender'],
                                          onChanged: (var val) {
                                            setState(() {
                                              bmi['Gender'] = val;
                                            });
                                          },
                                        ),
                                        RaisedButton(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          color: Theme.of(context).accentColor,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }).then((value) => setState(() {}));
                    },
                    child: _card(
                      'Gender',
                      bmi['Gender'],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dialogScreen('Age');
                    },
                    child: _card(
                      'Age in Years',
                      bmi['Age'],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      dialogScreen('Weight');
                    },
                    child: _card(
                      'Weight in kg',
                      bmi['Weight'],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dialogScreen('Height');
                    },
                    child: _card(
                      'Height in cm',
                      bmi['Height'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _tile('Underweight', (colors['Underweight'])!),
                  _tile('Normal', (colors['Normal'])!),
                  _tile('Overweight', (colors['Overweight'])!),
                  _tile('Obese', (colors['Obese'])!),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12,
                  top: 12,
                  bottom: 4,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${bmi['Result']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Text(
                        '${bmi['BMI']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
                width: MediaQuery.of(context).size.width * 0.94,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 5,
                  bottom: 15,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${bmi['Message']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width * 0.93,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _bottomTile('Underweight', 'BMI of 18.49 or below'),
                    _bottomTile('Normal', 'BMI of 18.5 - 24.99'),
                    _bottomTile('Overweight', 'BMI of 25 - 29.99'),
                    _bottomTile('Obese', 'BMI of 30 or above'),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // ignore: deprecated_member_use
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  onPressed: () {
                    if (bmi['Gender'] == '?' ||
                        bmi['Age'] == 0 ||
                        bmi['Height'] == 0 ||
                        bmi['Weight'] == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fill all cards and press calculate.'),
                        ),
                      );
                    } else {
                      setState(() {
                        calculateBmi();
                      });
                    }
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  color: Color(0xff0d5c63),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfff7f7f7),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String label, var value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.34,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: const BoxDecoration(
        color: Color(0xFF0D5C63),
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff918d8d),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 52,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Color(0xFFf7f7f7),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              color: Color(0xfff7f7f7),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(String label, Color color) {
    return Column(
      children: [
        Container(
          height: 15,
          width: MediaQuery.of(context).size.width * 0.22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  Widget _bottomTile(String name, String value) {
    return Row(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void dialogScreen(String label) {
    late int value;
    if (label == 'Age') {
      value = bmi['Age'];
    } else if (label == 'Height') {
      value = bmi['Height'];
    } else {
      value = bmi['Weight'];
    }
    TextEditingController _value = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    onChanged: (val) {
                      try {
                        int temp = int.parse(val.trim());
                        setState(() {
                      value = temp;
                    });
                      }catch(e){
                        print(e);
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '$label can\'t be empty.';
                      } else {
                        return null;
                      }
                    },
                    controller: _value,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 3,
                    //autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2.0,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      helperStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      labelText: '$label : $value',
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        if (isValid) {
                          formKey.currentState!.save();
                        }
                        if (_value.text.isNotEmpty) {
                          if (label == 'Age') {
                            bmi['Age'] = int.parse(_value.text);
                          } else if (label == 'Height') {
                            bmi['Height'] = int.parse(_value.text);
                          } else {
                            bmi['Weight'] = int.parse(_value.text);
                          }
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).then((value) => setState(() {}));
  }
}
