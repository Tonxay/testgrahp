import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:simple_graphql_query/models/book_model.dart';
import 'package:simple_graphql_query/providers/book_provider.dart';
import 'package:simple_graphql_query/screens/Form_insert_boobs.dart';
import 'package:simple_graphql_query/screens/update_book.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Snapshot<List<BooksModel>>? _getBooks;
  bool _isLoading = false;

  Future fetchOperation() async {
    setState(() {
      _isLoading = true;
    });
    BooksProvider.subAllBook().asStream().listen((event) {
      setState(() {
        _getBooks = event;
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    fetchOperation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(resp);
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple GraphQL"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<BooksModel>>(
                  stream: _getBooks,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error Occurred!");
                    }
                    return snapshot.hasData
                        ? _isLoading
                            ? Center(
                                child: Text("Loading...."),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.add_box_outlined),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyWidget()));
                                            }),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, idx) {
                                            BooksModel item =
                                                snapshot.data![idx];
                                            return Card(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Author name: " +
                                                              item.author),
                                                          Text(item.bookName),
                                                          Text("Page no. " +
                                                              item.pages
                                                                  .toString()),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            update_book(
                                                                              booksModel: item,
                                                                            )));
                                                          }),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outlined,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () async {
                                                            await BooksProvider
                                                                .Delete(
                                                                    id: item
                                                                        .author);
                                                          }),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                            ;
                                          }),
                                    ),
                                  ],
                                ),
                              )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
