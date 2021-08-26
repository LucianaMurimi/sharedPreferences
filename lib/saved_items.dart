import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedItems extends StatefulWidget {
  // const SavedItems({Key? key}) : super(key: key);
  final String username;
  final String email;

  const SavedItems(this.username, this.email);


  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  var nameItems = [];
  var emailItems = [];

  void initState(){
    nameItems = widget.username.split(',');
    emailItems = widget.email.split(',');
    super.initState();
  }

  //1. Delete Data
  void _deleteValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('passwd');
    setState(() {
      nameItems = [];
      emailItems = [];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Items'),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: nameItems.length,
                  itemBuilder: (context, i){
                    return ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('${nameItems.elementAt(i)}'),
                      subtitle: Text('${emailItems.elementAt(i)}'),
                    );
                  }
              ),
            ),

            Container(
              padding: EdgeInsets.only(top:4.0, bottom: 4.0, left: 8.0, right: 8.0),
              // width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: new BorderRadius.circular(16.0),
              ),

              child: TextButton(
                onPressed: (){
                  _deleteValue();
                },
                child: Text('Delete All',
                    style: TextStyle(color: Color(0xFFffffff), fontSize: 16.0, fontWeight: FontWeight.bold, letterSpacing: 2)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}