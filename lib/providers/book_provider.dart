import 'package:hasura_connect/hasura_connect.dart';
import 'package:simple_graphql_query/models/book_model.dart';
import 'package:simple_graphql_query/utils/hasura_helper.dart';

class BooksProvider {
  static Future<List<BooksModel>> fetAllAds() async {
    //document
    String docQuery = """
      query {
          books {
          author
          bookName
          createAt
          pages
        }
      }
    """;
    //get query
    var r = await HasuraHelper.hasuraConn().query(docQuery);
    List<BooksModel> ads = (r['data']['books'] as List)
        .map((value) => BooksModel.fromJson(value))
        .toList();
    return ads;
  }

  static Future<BooksModel> insert(
      {required String author,
      required String bookName,
      required int pages}) async {
    //document

    String insert = """
        mutation MyMutation(\$createAt: timestamp,\$author: String,\$bookName: String ,\$pages: Int,) {
          insert_books(objects: {author: \$author,bookName: \$bookName,createAt: \$createAt, pages: \$pages}) {
            returning {
              author
              bookName
              pages
            }
          }
        }
    """;

    print(pages);
    var r = await HasuraHelper.hasuraConn().mutation(insert, variables: {
      'createAt': DateTime.now().toString(),
      'author': author,
      'bookName': bookName,
      'pages': pages
    });
    print(r);

    BooksModel ads = BooksModel(author: author, bookName: bookName, pages: 10);
    return ads;
  }

  static Future<dynamic> update_book(
      {required String author,
      required String bookName,
      required int pages}) async {
    String updatebook = """
mutation MyMutation(\$bookName: String , \$pages:Int,\$createAt: timestamp\$author: String){
  update_books(where: {author: {_eq: \$author}}, _set: {bookName: \$bookName, pages: \$pages, createAt: \$createAt}) {
    returning {
      author
      pages
      createAt
      bookName
    }
  }
}
 """;
    var up = await HasuraHelper.hasuraConn().mutation(updatebook, variables: {
      'createAt': DateTime.now().toString(),
      'author': author,
      'bookName': bookName,
      'pages': pages
    });
    return up;
  }

  static Future<dynamic> Delete({String? id}) async {
    String Delete = """
       mutation Dalete(\$author: String){
        delete_books(where: {author: {_eq: \$author}}) {
    returning {
      author
    }
  }
 }
""";

    await HasuraHelper.hasuraConn().mutation(Delete, variables: {'author': id});
  }

  static Future<Snapshot<List<BooksModel>>> subAllBook() async {
    //document
    String docQuery = """
      subscription {
           books {
            author
             bookName
              createAt
                   pages
  }
     }
    """;
    //get subscription
    var connector = HasuraHelper.hasuraConn();
    Snapshot snapshot = await connector.subscription(docQuery);
    return snapshot.map((data) {
      return BooksModel.fromJsonList(data["data"]["books"]);
    });
  }
}
