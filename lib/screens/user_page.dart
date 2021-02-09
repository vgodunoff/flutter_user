import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user/data.dart';

class UserPage extends StatefulWidget {
  String urlImage;
  int id;
  String name;
  String lastName;
  String email;
  String url;
  String text;
  UserPage(
      {this.urlImage,
      this.id,
      this.name,
      this.lastName,
      this.email,
      this.url,
      this.text});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<Map> mapUserPage;
  Data data = Data();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapUserPage = data.getData(Data.urlUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User page'),
      ),
      body: FutureBuilder(
        future: mapUserPage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> mapUserPage = snapshot.data;
            return SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.urlImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('id: ${widget.id.toString()}'),
                            Text('name: ${widget.name} ${widget.lastName}'),
                            Text('email: ${widget.email}'),
                            Divider(),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('support'),
                        Text(mapUserPage['support']['url']),
                        Text(mapUserPage['support']['text']),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
