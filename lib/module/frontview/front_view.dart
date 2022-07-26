
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ou_rest/config/constants.dart';
import 'package:ou_rest/widgets/searchbar.dart';
import 'package:provider/provider.dart';



class frontView extends StatelessWidget {
  const frontView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      //appBar: AppBar(title:Text("page1")),
      
      body: Stack(
        children: [
        Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: defaultAmber,
                ),
              ),
              const Expanded(
                flex:6,
                child: Preview()),
              const Expanded(
                flex:8,
                child: FrontMenuTab()
                ),
              const Divider(),
              Expanded(
                flex:6,
                child:
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      bottomWidget(width: width),
                    ],
                  )))
            ],
        ),
          const searchBar()
        ]

      ),
        backgroundColor: Colors.white,
    );
  }
}


// class frontView extends StatelessWidget {
//   const frontView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("hi")
//     );
//   }
// }


class Preview extends StatelessWidget {
  const Preview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    var name = "서울시";
    var sort = "가족";
    var score = 80;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // final controller = Get.put(FrontController());
    return Container(
      color:  const Color(0xffFCB01D),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name\n$sort화장실", 
                      maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    )
                      ),
                    const SizedBox(
                      height: 1,
                    ),
                  Text(
                      "평점 $score인 \n최고급 화장실입니다.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      },
                    child: const Text("더 알아보기", style: TextStyle(color: Colors.amber)),
                    )
                ],
              ),
             ),
             SizedBox(
                  width: width * 0.05,
                ),
             Container(
              width: width * 0.35,
              alignment: const Alignment(0, 0),
              child: Image.asset("./assets/images/pin.png")
              )  
          ],
        ),
      ),
    );
  }
}



class FrontMenuTab extends StatefulWidget {
  const FrontMenuTab({Key? key}) : super(key: key);

  @override
  State<FrontMenuTab> createState() => _FrontMenuTabState();
}

class _FrontMenuTabState extends State<FrontMenuTab>
    with TickerProviderStateMixin {
  late TabController controller_;
  late TabBar tabbar_;
  @override
  void initState() {
    // TODO: implement initState

    controller_ = TabController(vsync: this, length: 3);
    tabbar_ = TabBar(controller: controller_, tabs: const [
      Tab(
        child: Text(
          "지도",
          style: TextStyle(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      Tab(
        child: Text(
          "다락방",
          style: TextStyle(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      Tab(
        child: Text(
          "쇼핑몰",
          style: TextStyle(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: tabbar_.preferredSize,
            child: Card(color: Colors.white, child: tabbar_)),
        backgroundColor: Colors.white,
        body:
            TabBarView(controller: controller_, viewportFraction: 1, children: const [
          menu_base(),
          Center(child: Text("공사중입니다.")),
          Center(child: Text("공사중입니다.")),
        ]));
  }
  }

class menu_base extends StatelessWidget {
  const menu_base({
    Key? key,
  }) : super(key: key);

  Widget _buildButton({
    required double width,
    required IconData icons,
    required String text,
    required Color color,
    required String target,
    required String sort,
  }) {
    return TextButton(
      onPressed: () {
        //Get.toNamed(target, arguments: sort);
      },
      child: SizedBox(
        width: width * 0.19,
        height: width * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.15,
              height: width * 0.15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icons,
                color: Colors.black54,
                size: 30,
              ),
            ),
            Text(text, style: const TextStyle(color: Colors.black54,fontSize:12))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Wrap(
          spacing: 1.0,
          runSpacing: 1.0,
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
            children: [
            _buildButton(
                width: width,
                icons: Icons.family_restroom,
                text: "가족화장실",
                color: const Color(0xFFFFF9EF),
                target: "map push",
                sort: ""),
            _buildButton(
                width: width,
                icons: Icons.wc,
                text: "장애인화장실",
                color: const Color(0xffFAF4FF),
                target: "map push",
                sort: ""),
            _buildButton(
                width: width,
                icons: Icons.car_repair,
                text: "주차장",
                color: const Color(0xffEFFFF2),
                target: "map push",
                sort: ""),
            _buildButton(
                width: width,
                icons: Icons.local_cafe,
                text: "추천카폐",
                color: const Color(0xffFFEFFC),
                target: "map push",
                sort: ""),
            _buildButton(
                width: width,
                icons: Icons.restaurant,
                text: "추천식당",
                color: const Color(0xffFFEFEF),
                target: "map push",
                sort: ""),
          ],
              ),
      ),
    );
  }
}

class bottomWidget extends StatelessWidget {
  const bottomWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 150,
      //decoration: elementDeco,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("이곳은 어떠신가요?",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),
                InkWell(
                  child: const Text("더보기", style: TextStyle(
                    color: defaultAmber
                  ),),
                  onTap: (){
                    GoRouter.of(context).go("/details");
                  },
                  ),
              ],
            ),
          ),
        
          Padding(
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
                        child: Image.network('https://picsum.photos/250?image=9'),
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
                        children: const [
                        Text("이동이 편한 카페", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("이동이 편해지도록 인테리어가 디자인된 유니버셜 카페에요.", ),
                        ],
                      ),
                    )),
                    Expanded(
                    flex:1,
                    child: Row(
                      children: const [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        ),
                        Text("4.5",
                        style: TextStyle(
                          fontWeight:FontWeight.bold
                        )
                        ,)
                      ],
                    )),
                ],
              )),
          )
        
        
        ],
      ));
  }
}
