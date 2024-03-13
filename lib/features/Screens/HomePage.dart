
import 'package:bookstore/components/book_card.dart';
import 'package:bookstore/components/scaffold_page.dart';
import 'package:bookstore/Controller/book_controller.dart';
import 'package:bookstore/features/books/data/model/readBookModel.dart';
import 'package:bookstore/features/books/data/model/searched_model.dart';
import 'package:bookstore/res/constant_page.dart';
import 'package:bookstore/res/helper/sharedPrefs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// import 'package:searchfield/searchfield.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookController bookController = Get.find<BookController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartData();
  }

  RxBool isSearched = false.obs;
  String queryString = "";
  SearchedBookModel? foundBooks;
  List<AlreadyReadBookModel>? bookCollection = [];
  void getCartData() async {
    try {
      String? bookResponseData = await bookController.fetchBooks();

      bookCollection = alreadyReadBookModelFromJson(bookResponseData);
      // print("bookCollection $bookCollection");
      setState(() {});
    
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }



  void searchMethod(String query) async {
    try {
      String? bookSearchResponseData = await bookController.searchBooks(query);
      foundBooks = searchedBookModelFromJson(bookSearchResponseData);
      print("foundBooks: $foundBooks");
    } on Exception catch (e) {
      print("error on SearchMethod: ${e.toString()}");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageScaffold(
      heading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: SizedBox(
                  height: Constant.height / 18,
                  width: Constant.width / 1.3,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      queryString = value;
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      errorBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      labelText: 'Search by Title',
                      hintText: 'Search \'Books by Title\'',
                    ),
                  )),
            ),
            GestureDetector(
                onTap: () {
                  isSearched.value = !isSearched.value;
                  if (isSearched.value) {
                    searchMethod(queryString);
                  } else {
                    searchController.clear();
                    bookController.isLoading.value = false;
                  }
                },
                child: Obx(() => Icon(
                      isSearched.value == false ? Icons.search : Icons.clear,
                      color: Colors.black,
                      size: 35,
                    )))
            // cartIcon(productController),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Expanded(
            child: Obx(() => bookController.isLoading.value == true
                ? const Center(child: CircularProgressIndicator())
                : isSearched.value == false
                    ? BookGridView(
                        bookModelNew: bookCollection!,
                      )
                    : BookSearchGridView(foundBooks: foundBooks!))
            // return SizedBox(
            //     height: Constant.height / 2,
            //     width: Constant.width / 2,
            //     child: const Text("else"));

            ),
      ),
    );
  }
}

class BookGridView extends StatelessWidget {
  List<AlreadyReadBookModel> bookModelNew;
  BookGridView({super.key, required this.bookModelNew});
  RxBool isRead = false.obs;
  RxInt isReadIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        height: Constant.height / 1.2,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: bookModelNew.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => BookCard(
                  image:
                      "https://covers.openlibrary.org/b/id/${bookModelNew[index].work!.coverId}-M.jpg",
                  bookName: bookModelNew[index].work!.title!,
                  firstAuthor: bookModelNew[index].work!.authorNames!.first,
                  publishedYear:
                      bookModelNew[index].work!.firstPublishYear.toString(),
                  bookStatus: isRead.value,
                  onChanged: (value) {
                    isRead.value = value;
                    isReadIndex.value = index;
                  },
                ));
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisExtent: Constant.height / 2.8),
        ),
      ),
    );
  }
}

class BookSearchGridView extends StatelessWidget {
  SearchedBookModel foundBooks;
  BookSearchGridView({super.key, required this.foundBooks});
  RxBool isRead = false.obs;
  RxInt isReadIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        height: Constant.height / 1.2,
        child: foundBooks.numFound == 0
            ? const Center(
                child: Text("No Result"),
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: foundBooks.numFound,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => BookCard(
                        image:
                            "https://covers.openlibrary.org/b/id/${foundBooks.docs![index].coverI ?? 0}-M.jpg",
                        bookName: foundBooks.docs![index].title ?? "",
                        firstAuthor: foundBooks.docs![index].authorName!.first,
                        publishedYear:
                            foundBooks.docs![index].firstPublishYear.toString(),
                        bookStatus: isRead.value,
                        onChanged: (value) {
                          isRead.value = value;
                          isReadIndex.value = index;
                        },
                      ));
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisExtent: Constant.height / 2.8),
              ),
      ),
    );
  }
}
