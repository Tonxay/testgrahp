import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_graphql_query/models/book_model.dart';
import 'package:simple_graphql_query/providers/book_provider.dart';

class update_book extends StatefulWidget {
  BooksModel booksModel;
  update_book({Key? key, required this.booksModel}) : super(key: key);

  @override
  State<update_book> createState() =>
      _update_bookState(booksModel: this.booksModel);
}

class _update_bookState extends State<update_book> {
  BooksModel booksModel;
  _update_bookState({required BooksModel this.booksModel});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    booksModel = this.booksModel;
    print(booksModel.author);
  }

  final _formKey = GlobalKey<FormState>();
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
                    'UPDATE DATA TO HASURA',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    initialValue: booksModel.author,
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
                    onChanged: (v) {
                      booksModel.author = v.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: booksModel.bookName,
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
                    onChanged: (v) {
                      booksModel.bookName = v.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: booksModel.pages.toString(),
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
                    onChanged: (v) {
                      booksModel.pages = int.parse(v.toString());
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 3, 136, 172), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      await BooksProvider.update_book(
                          author: booksModel.author,
                          bookName: booksModel.bookName,
                          pages: booksModel.pages);
                    },
                    child: Text('UPDATE NEW'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
