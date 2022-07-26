import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ou_rest/config/constants.dart';
import 'package:ou_rest/module/frontdetailview/front_detail_model.dart';


class frontDetailView extends StatelessWidget {
  frontDetailView({Key? key}) : super(key: key);

  // Map<String,dynamic> recommends = detail_cafe.element.items();
  var a = detail_cafe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  alignment: Alignment.bottomRight,
                  child: Text("유니버셜 카페",style: smTitle.copyWith(fontSize: 25),),
                ),
              ),
              Expanded(
                child: listview_details(
                details: a,
        ),
              ),
            ],
          ),
          Positioned(
              top: 83,
              left: 20,
              child: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () => GoRouter.of(context).pop(),
              )
          )

        ]
      ),
    );
  }
}

class listview_details extends StatefulWidget {
  final details;
  listview_details({
    required this.details,
    Key? key}) : super(key: key);

  @override
  State<listview_details> createState() => _listview_detailsState();
}

class _listview_detailsState extends State<listview_details> {
  @override
  Widget build(BuildContext context) {
    final e = widget.details;




    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: e.elementsItem.length,
      itemBuilder: (BuildContext context, int index){
        final String title =e.elementsItem[index]["title"];
        final String star  =e.elementsItem[index]["star"];
        final String address  =e.elementsItem[index]["address"];
        final String subtitle  =e.elementsItem[index]["subtitle"];
        final String imgsrc  =e.elementsItem[index]["imgsrc"];
        // var title = "title";
        // var star = "4.2";
        // var address = "주소";
        // var subtitle = "서브타이틀";



        return Container(
            height: 200,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(40)
                        ),
                        child: Image.network(
                          imgsrc,
                          height: 90,
                          width: 90,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start
                            ,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                        fit:BoxFit.fitWidth,
                                        child: Text("${title}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.yellow,),
                                        Text("${star}")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text("${address}",style: smTitle.copyWith(fontSize: 12))),
                              Expanded(
                                  flex: 2,
                                  child: Text("${subtitle}",style: smTitle,)),


                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 10,
        color: defaultAmber,
      ),
    );
  }

}
