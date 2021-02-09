import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user/data.dart';
import 'package:flutter_user/screens/user_page.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Future<Map> _futureMapUser;
  Data _data = Data();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureMapUser = _data.getData(Data.urlUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder(
        future: _futureMapUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var users = snapshot.data;
            List list = users['data'];
            print(list);
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(list[index]['avatar']),
                      ),
                      title: Center(
                          child: Text('id: ${list[index]['id'].toString()}')),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'name: ${list[index]['first_name']} ${list[index]['last_name']}'),
                          Text('email: ${list[index]['email']}')
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              urlImage: list[index]['avatar'],
                              id: list[index]['id'],
                              name: list[index]['first_name'],
                              lastName: list[index]['last_name'],
                              email: list[index]['email'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
