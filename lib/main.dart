import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'saved_items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      debugShowCheckedModeBanner: false,
      home: DiskStorageDemo(),
    );
  }
}

class DiskStorageDemo extends StatefulWidget {
  const DiskStorageDemo({Key? key}) : super(key: key);

  @override
  _DiskStorageDemoState createState() => _DiskStorageDemoState();
}

class _DiskStorageDemoState extends State<DiskStorageDemo> {
  var _username = '';
  var _email = '';
  var _passwd = '';
  
  bool show = false;

  //1. Saving Data
  void _setValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final username = (prefs.getString('username') ?? '') + ',' + _username;
      final email = (prefs.getString('email') ?? '') + ',' + _email;
      final passwd = (prefs.getString('passwd') ?? '') + ',' + _passwd;

      prefs.setString('username', username);
      prefs.setString('email', email);
      prefs.setString('passwd', passwd);
    });
  }

  //2. Read Data
   Future<void> _getValues() async {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? '';
      final email = prefs.getString('email') ?? '';
      final passwd = prefs.getString('passwd') ?? '';

      setState(() {
        _username = username;
        _email = email;
        _passwd = passwd;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),

          child: Column(
            children: [

              // Welcome text
              Container(
                child: Text('Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Prata', fontSize: 32),
                ),
              ),

              SizedBox(height: 40,),

              // Name
              TextFormField(
                onChanged: (val){setState(() {
                  _username = val;
                });},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 24.0),
                  border: UnderlineInputBorder(),
                  hintText: 'name',
                  hintStyle: TextStyle(fontSize: 12.0, fontFamily: 'Montserrat'),
                ),
              ),

              SizedBox(height: 24,),

              // Email
              TextFormField(
                onChanged: (val){setState(() {
                  _email = val;
                });},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 24.0),
                  border: UnderlineInputBorder(),
                  hintText: 'email',
                  hintStyle: TextStyle(fontSize: 12.0,),
                ),
              ),

              SizedBox(height: 24,),

              // Password
              TextFormField(
                obscureText: true,
                onChanged: (val){setState(() {
                  _passwd = val;
                });},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 24.0),
                  border: UnderlineInputBorder(),
                  hintText: 'password',
                  hintStyle: TextStyle(fontSize: 12.0,),
                ),
              ),

              SizedBox(height: 48,),

          Row( //Buttons Save & Show
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Save
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top:4.0, bottom: 4.0),

                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: new BorderRadius.circular(16.0),
                  ),

                  child: TextButton(
                    onPressed: (){
                      _setValues();
                    },
                    child: Text('Save',
                        style: TextStyle(color: Color(0xFFffffff), fontSize: 16.0, fontWeight: FontWeight.bold, letterSpacing: 2)
                    ),
                  ),
                ),
              ),

              SizedBox(width: 24,),

              // Show
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top:4.0, bottom: 4.0),

                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: new BorderRadius.circular(16.0),
                  ),

                  child: TextButton(
                    onPressed: (){
                      _getValues();

                      //Navigate to SavedItems screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SavedItems(_username, _email)),
                      );

                    },
                    child: Text('Show',
                        style: TextStyle(color: Color(0xFFffffff), fontSize: 16.0, fontWeight: FontWeight.bold, letterSpacing: 2)
                    ),
                  ),
                ),
              ),
            ],
          )


            ],
          ),
        ),
      ),
    );
  }
}





