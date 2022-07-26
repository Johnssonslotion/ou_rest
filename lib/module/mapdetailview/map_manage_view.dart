import 'package:flutter/material.dart';

class mapMangeView extends StatelessWidget{

  //final String tID;
  const mapMangeView({
    //required this.tID,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width =  MediaQuery.of(context).size.width;
    var urls  = 'https://design.seoul.go.kr/file/project/image/750/85';


    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.2),
          child: AppBar(
            elevation: 0,
            leadingWidth: 100,
            leading: IconButton(
              icon: Opacity(
                opacity: 0.7,
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.arrow_back)),
              ),
              onPressed: () {
                //back
              },
            ),
            flexibleSpace: Stack(
                children: [
                  SizedBox(
                    width: width,
                    child: Image(
                      image: NetworkImage(
                          urls
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.white,
                            ],
                            stops: const [
                              0.0,
                              1.0
                            ])),
                  )
                ]),
            actions: [
              Row(
                children: [
                  TextButton(
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateColor
                    // ),
                      onPressed: () {},
                      child: Opacity(
                        opacity: 0.7,
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black38),
                          child: const Center(
                            child: Text(
                              "사진보기",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(width: 10,)
                ],
              )
            ],
          ),
        ),
        extendBody: true,
        body: SingleChildScrollView(
            child:Column(
              children: const [
                Expanded(flex: 10,child: Text("hello"),),
                Expanded(flex: 10,child: Text("hello"),),
                Expanded(flex: 40,child: Text("hello"),),
              ],
            )
        )

    );
  }
}
