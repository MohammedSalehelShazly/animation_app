import 'dart:math';

import 'package:flutter/material.dart';

class BurgerComp extends StatefulWidget {
  @override
  _BurgerCompState createState() => _BurgerCompState();
}

class _BurgerCompState extends State<BurgerComp> {

  List<String> chosenBread = breadM;
  List<bool> chosenBreadBorder = [false ,false ,true ,false];

  static List<String> breadM = ['assets/images/BMT.png' ,'assets/images/BMB.png'];
  static List<String> breadB = ['assets/images/BBT.png' ,'assets/images/BBB.png'];
  static List<String> breadG = ['assets/images/BGT.png' ,'assets/images/BGB.png'];
  static List<String> breadO = ['assets/images/BOT.png' ,'assets/images/BOB.png'];

  Map<String ,dynamic> burgerComp = {
    'assets/images/1-cheese.png' :-20,
    'assets/images/2-burger.png' :20,
    'assets/images/3-tomatoRow.png' :-20,
    'assets/images/5-lettuce.png' :20,
  };
  static double ratioHeight = 0.8;
  double sHeight ()=>MediaQuery.of(context).size.height;
  double sWidth ()=>MediaQuery.of(context).size.width;

  ScrollController homeScrollController = ScrollController();
  bool pushPage = true;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener(
          onNotification: (t) {
            print(homeScrollController.offset);
            if(homeScrollController.offset >= 60  && pushPage==true){
              Navigator.of(context).pop();
              pushPage = false;
            }
            return null ;
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: homeScrollController,
            child: Container(
              height: sHeight()*1.01,
              child: Stack(
                children: [
                  Hero(
                    tag: 'bgTag',
                    child: Container(
                      height: sHeight() *ratioHeight,
                      width: sWidth(),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/geenBckground.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
    
                  Container(
                    height: sHeight() *ratioHeight,
                    width: sWidth(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(burgerComp.length+chosenBread.length, (index){
    
                        return index==0 || index==(burgerComp.length+chosenBread.length)-1 ?
                        Transform.rotate(
                          angle: index==0 ? 20 *pi/180 :-20 *pi/180,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 5000),
                            key: index==0 ? ValueKey(0) : ValueKey(1),
                            child: index==0 ?Container(
                              height: (sHeight()*ratioHeight) / (burgerComp.length+chosenBread.length),
                              width: sWidth() *0.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(chosenBread[0]),
                                      fit: BoxFit.fitWidth
                                  )
                              ),
                            ):
                            Container(
                              height: (sHeight()*ratioHeight) / (burgerComp.length+chosenBread.length),
                              width: sWidth() *0.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(chosenBread[1]),
                                      fit: BoxFit.fitWidth
                                  )
                              ),
                            ),
                          ),
                        )
    
                            : Hero(
                            tag: index == 2
                              ? 'main_burger_tag'
                              : 'main_burger_tag_$index',
                            child: Transform.rotate(
                                  angle: burgerComp.values.toList()[index-1] *pi/180,
                                  child: Container(
                                    height: (sHeight()*ratioHeight) / (burgerComp.length+chosenBread.length),
                                    width: sWidth() *0.4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage( burgerComp.keys.toList()[index-1] ),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                                  ),
                            );
    
                      }),
                    ),
                  ),
    
    
                  Positioned(
                    top: sHeight() *ratioHeight,
                    child: Container(
                      width: sWidth(),
                      height: MediaQuery.of(context).size.width /3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                          alignment: Alignment.topCenter,
                          child: BurgerOption(
                              img: 'assets/images/BB.png',
                              setFunc: () => setState(() {
                                chosenBread = breadB;
                                chosenBreadBorder = [true ,false ,false ,false];
                              }),
                              selected: chosenBreadBorder[0] == true),
                        ),
                        BurgerOption(
                            img: 'assets/images/BG.png',
                            setFunc: () => setState(() {
                              chosenBread = breadG;
                              chosenBreadBorder = [false ,true ,false ,false];
                            }),
                            selected: chosenBreadBorder[1] == true),
                        BurgerOption(
                            img: 'assets/images/BM.png',
                            setFunc: () => setState((){
                              chosenBread = breadM;
                              chosenBreadBorder = [false ,false ,true ,false];
                            }),
                            selected: chosenBreadBorder[2] == true),
                        Align(
                            alignment: Alignment.topCenter,
                            child: BurgerOption(
                                img: 'assets/images/BO.png',
                                setFunc: () => setState(() {
                                  chosenBread = breadO;
                                  chosenBreadBorder = [false ,false ,false ,true];
                                }),
                                selected: chosenBreadBorder[3] == true)),
                      ],
                      ),
                    ),
                  ),
    
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}

class BurgerOption extends StatelessWidget {
  final String img;
  final Function setFunc;
  final bool selected;
  BurgerOption({
    @required this.img,
    @required this.setFunc,
    @required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setFunc();
      },
        child: Container(
          height: MediaQuery.of(context).size.width /5,
          width: MediaQuery.of(context).size.width /5,
          padding: EdgeInsets.all(10),
          child: Image.asset( img ),
          decoration: BoxDecoration(
            border: Border.all(color: selected? Color(0xff91CF55): Colors.transparent ,width: 4),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black54 ,Colors.black87 ,Colors.black ,]
            ),
            shape: BoxShape.circle
          ),
        ),
    );
  }
}