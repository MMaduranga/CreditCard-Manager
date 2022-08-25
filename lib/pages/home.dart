//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _focusedIndex=0;
  int itemCount=3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
            )),
      ),
      body:Row(
        children: [
          Expanded(
              child: ScrollSnapList(
            itemBuilder: _container,
              itemSize: MediaQuery.of(context).size.width*0.9,
            itemCount: itemCount,
            dynamicItemSize: true,
            onItemFocus: _onItemFocus,
          )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
        child:const Icon(
          Icons.add,
        ),
      ),

    );
  }
  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }
Widget _container(BuildContext context,int index){
    return Container(
      margin:const EdgeInsets.only(top: 20.0,bottom: 50.0),
      height: MediaQuery.of(context).size.height - AppBar().preferredSize.height
          - MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 5.0,
              offset: Offset(10, 10),
              color: Color(0xFFA7A9AF),
              inset: true),
          BoxShadow(
            blurRadius: 5,
            offset: Offset(-10, -10),
            color: Colors.white,
            inset: true,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
       child: content(),
    );

}
  Center content() => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 5),
            child: Column(
              children: [
                card(),


              ],
            ),
          ),
        ),
      );
  Card card()=>Card(
    color: Colors.grey[200],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:  [
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle:
          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),

        FixedTimeline.tileBuilder(
          direction: Axis.vertical,
          builder: TimelineTileBuilder.connectedFromStyle(
            connectionDirection: ConnectionDirection.after,
            connectorStyleBuilder: (context, index) {
              return (index == 1) ? ConnectorStyle.dashedLine : ConnectorStyle.solidLine;
            },
            indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
            itemExtent: 40.0,
            itemCount: 3,
          ),
        )

      ],
    ),
  );
}
