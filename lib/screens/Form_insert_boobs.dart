import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_graphql_query/models/book_model.dart';
import 'package:simple_graphql_query/providers/book_provider.dart';

class MyWidget extends StatefulWidget {
  MyWidget({Key? key, booksModel}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController author = TextEditingController();
  TextEditingController bookName = TextEditingController();
  TextEditingController pages = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'INSERT DATA TO HASURA',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: author,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 23, 22, 22)),
                    decoration: InputDecoration(
                      hintText: '',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: bookName,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 23, 22, 22)),
                    decoration: InputDecoration(
                      hintText: '',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: pages,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 23, 22, 22)),
                    decoration: InputDecoration(
                      hintText: '',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Color.fromARGB(255, 3, 136, 172), // foreground
                    ),
                    onPressed: () async {
                      await BooksProvider.insert(
                          author: author.value.text,
                          bookName: bookName.value.text,
                          pages: int.parse(pages.value.text));
                      _formKey.currentState!.reset();
                    },
                    child: Text('INSERT NEW'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
