import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ou_rest/config/constants.dart';
import 'package:ou_rest/module/bookview/book_model.dart';



class bookView extends StatelessWidget {
  //var details;
  bookView({
    //required this.details,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var e = detail_bookmark();
    return Scaffold(
      body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark,size:30),
                        Text("북마크",style: smTitle.copyWith(fontSize: 25),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: listview_details(
                    // details: e,
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }
}



class listview_details extends StatefulWidget {
  // final details;
  listview_details({
    // required this.details,
    Key? key}) : super(key: key);

  @override
  State<listview_details> createState() => _listview_detailsState();
}

class _listview_detailsState extends State<listview_details> {
  @override
  Widget build(BuildContext context) {
    final e = detail_bookmark();

    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: e.elementsItem.length,
      itemBuilder: (BuildContext context, int index){
        return cards(carditem: e.elementsItem[index],);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 10,
        color: defaultAmber,
      ),
    );
  }
}





class cards extends StatelessWidget {
  final carditem;
  cards({
    required this.carditem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width= MediaQuery.of(context).size.width;
    final String name    =  carditem["title"] ;
    final String address =  carditem["address"];
    final String count   =  carditem["count"];
    final String src     =  carditem["imgsrc"];

    return SizedBox(
        width: width,
        height: 100,
        //decoration: elementDeco,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: width,
              //height: 70,
              //color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      // color: Colors.red,
                      child: Container(
                        decoration: elementDeco.copyWith(borderRadius:BorderRadius.circular(10),),
                        child: Image.network(src),
                      ),
                    ),
                  ),
                  Expanded(
                      flex:3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text("${name}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${address}"),
                          ],
                        ),
                      )),
                  Expanded(
                      flex:1,
                      child: Row(
                        children:[
                          Icon(
                            Icons.bookmark,
                            color: Colors.black45,
                          ),
                          Text("${count}",
                            style: TextStyle(
                                fontWeight:FontWeight.bold
                            )
                            ,)
                        ],
                      )),
                ],
              )),
        ));
  }
}