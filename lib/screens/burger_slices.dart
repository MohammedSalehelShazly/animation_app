import 'dart:developer' as dev;
import 'dart:math';

import 'package:animation_app/staticVars.dart';
import 'package:flutter/material.dart';

class BurgerSlices extends StatefulWidget {
  @override
  _BurgerSlicesState createState() => _BurgerSlicesState();
}

class _BurgerSlicesState extends State<BurgerSlices> with TickerProviderStateMixin{

  List<String> chosenBread = staticVars.breadM;
  List<bool> chosenBreadBorder = [false ,false ,true ,false];

  static double ratioHeight = 0.8;
  double sHeight ()=>MediaQuery.of(context).size.height;
  double sWidth ()=>MediaQuery.of(context).size.width;

  ScrollController homeScrollController = ScrollController();
  bool pushPage = true;


  AnimationController curveCtrl;
  // AnimationController optionRowCtrl;
  Animation curveAnimation;
  Animation optionRowAnimation;

  void disposeFunc() {
    dev.log('dispose...............................................');
    curveCtrl.dispose();
    //optionRowCtrl.dispose();
  }
  initStateFunc() {
    Future.delayed(Duration(milliseconds: 100), () {
      curveCtrl =  AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
      //optionRowCtrl =  AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
      curveAnimation = Tween<double>(
          begin: bgHigh(context)*.8,
          end: bgHigh(context)
        ).animate(curveCtrl);
      optionRowAnimation = Tween<double>(
          begin: sHeight(),
          end: bgHigh(context)
        ).animate(curveCtrl..duration = Duration(milliseconds: 1500));
      curveCtrl.addListener(() {
        setState(() {});
      });
      // optionRowCtrl.addListener(() {
      //   setState(() {});
      // });
      curveCtrl.forward();
      // optionRowCtrl.forward();
    });
  }
  
  @override
  void dispose() {
    if(mounted){
      disposeFunc();
      dev.log('d...............................................');
    }
    super.dispose();
  }

  @override
  void initState() {
    initStateFunc();
  super.initState();
  }

  bgHigh(BuildContext context)=>
    sHeight() *ratioHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener(
          onNotification: (t) {
            // print(homeScrollController.offset);
            if(homeScrollController.offset >= 90  && pushPage==true){
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
                      height: curveAnimation?.value ?? bgHigh(context),
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
                    height: curveAnimation?.value ?? bgHigh(context),
                    width: sWidth(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(staticVars.burgerComp.length+chosenBread.length, (index){
    
                        return index==0 || index==(staticVars.burgerComp.length+chosenBread.length)-1 ?
                        Transform.rotate(
                          angle: index==0 ? 20 *pi/180 :-20 *pi/180,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 5000),
                            key: index==0 ? ValueKey(0) : ValueKey(1),
                            child: index==0 ?Container(
                              height: (curveAnimation?.value ?? bgHigh(context)) / (staticVars.burgerComp.length+chosenBread.length),
                              width: sWidth() *0.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(chosenBread[0]),
                                      fit: BoxFit.fitWidth
                                  )
                              ),
                            ):
                            Container(
                              height: (curveAnimation?.value ?? bgHigh(context)) / (staticVars.burgerComp.length+chosenBread.length),
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
    
                            : SizedBox(
                              height: (curveAnimation?.value ?? bgHigh(context)) / (staticVars.burgerComp.length+chosenBread.length),
                              child: Hero(
                              tag: index == 2
                                ? 'main_burger_tag'
                                : 'main_burger_tag_$index',
                              child: Transform.rotate(
                                    angle: staticVars.burgerComp.values.toList()[index-1] *pi/180,
                                    child: Container(
                                      height: (curveAnimation?.value ?? bgHigh(context)) / (staticVars.burgerComp.length+chosenBread.length),
                                      width: sWidth() *0.4,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage( staticVars.burgerComp.keys.toList()[index-1] ),
                                              fit: BoxFit.contain
                                          )
                                      ),
                                    ),
                                                    ),
                              ),
                            );
    
                      }),
                    ),
                  ),
    
    
                  Positioned(
                    top: (optionRowAnimation?.value ?? bgHigh(context)),
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
                                chosenBread = staticVars.breadB;
                                chosenBreadBorder = [true ,false ,false ,false];
                              }),
                              selected: chosenBreadBorder[0] == true),
                        ),
                        BurgerOption(
                            img: 'assets/images/BG.png',
                            setFunc: () => setState(() {
                              chosenBread = staticVars.breadG;
                              chosenBreadBorder = [false ,true ,false ,false];
                            }),
                            selected: chosenBreadBorder[1] == true),
                        BurgerOption(
                            img: 'assets/images/BM.png',
                            setFunc: () => setState((){
                              chosenBread = staticVars.breadM;
                              chosenBreadBorder = [false ,false ,true ,false];
                            }),
                            selected: chosenBreadBorder[2] == true),
                        Align(
                            alignment: Alignment.topCenter,
                            child: BurgerOption(
                                img: 'assets/images/BO.png',
                                setFunc: () => setState(() {
                                  chosenBread = staticVars.breadO;
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