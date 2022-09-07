
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../db/card.dart';
import '../db/database.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController addAmount = TextEditingController();
  final now = DateTime.now();
  final finalDate = DateTime.now().add(const Duration(days: 21));
  var billingDate = DateTime.now();
  int itemCount = 1;
  Color primaryColor = Colors.lightGreenAccent.shade700;
  List<CardDetail> _listData = [];
  int _focusedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    _listData = await DatabaseHandler().searchCard();
    itemCount = _listData.length;
    if (_listData.isEmpty) {
      emptyList();
    }
    _listData = arrangeCards(_listData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: ScrollSnapList(
              itemBuilder: _container,
              itemSize: MediaQuery.of(context).size.width * 0.9,
              itemCount: itemCount,
              dynamicItemSize: true,
              onItemFocus: _onItemFocus,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCard()));
        },
        child: const Icon(
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

  Widget _container(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 50.0),
      height: MediaQuery.of(context).size.height -
          AppBar().preferredSize.height -
          MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width * 0.9,
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
      child: (_listData.isEmpty) ? const Center() : content(index),
    );
  }

  Future<dynamic> emptyList() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddCard()));
  }

  Widget popupContainer(
      double dblHeight, double dblWidth, EdgeInsets edgeInsets, Widget cont,
      {double radius = 30.0}) {
    return Container(
      margin: edgeInsets,
      height: dblHeight,
      width: dblWidth,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 5.0,
              offset: Offset(7, 7),
              color: Color(0xFFA7A9AF),
              inset: false),
          BoxShadow(
            blurRadius: 5,
            offset: Offset(-7, -7),
            color: Colors.white,
            inset: false,
          ),
        ],
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: cont,
    );
  }

  void deleteCard(int index, String nickName) async {
    await DatabaseHandler().deleteCard(nickName).whenComplete(() =>
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  void updateAmount(int index, String nickName, double amount) async {}

  Widget content(int index) {
    CardDetail currentCard = _listData[index];
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              popupContainer(
                  50.0,
                  50.0,
                  const EdgeInsets.only(top: 20.0, right: 20.0),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text('delete this card?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                        deleteCard(index, currentCard.nickName);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      },
                      icon:  Icon(Icons.delete,color: primaryColor,)))
            ],
          ),
          Text(
            currentCard.nickName,
            style:  TextStyle(
              color:primaryColor,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 30.00,
          ),
          timeLine(index),
          const SizedBox(
            height: 30.0,
          ),
          popupContainer(
              200,
              200,
              const EdgeInsets.only(bottom: 20.0, right: 20.0),
              CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 20.0,
                percent: (currentCard.currentAmount/currentCard.cashLimit),
                center: Text("${(currentCard.currentAmount*100/currentCard.cashLimit).toStringAsFixed(3)}%"),
                progressColor: primaryColor,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
              ),
              radius: 100.0),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentCard.currentAmount.toString(),
                style: const TextStyle(fontSize: 25.0),
              ),
              popupContainer(
                  35,
                  35,
                  const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  Center(
                      child: IconButton(
                          onPressed: () async {
                            final amount = await openDialog();
                            CardDetail cardUpdate = currentCard;
                            cardUpdate.currentAmount +=
                                double.parse(amount.toString());
                            await DatabaseHandler()
                                .updateAmount(cardUpdate)
                                .whenComplete(() => {setState(() {})});
                          },
                          icon:  Icon(
                            Icons.add,
                            size: 20.0,
                            color: primaryColor,
                          ))),
                  radius: 5)
            ],
          ),
          Text(
            currentCard.cashLimit.toString(),
            style: const TextStyle(fontSize: 25.0),
          )
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Enter Amount"),
            content: TextField(
              controller: addAmount,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "value",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text("Done"),
              )
            ],
          ));
  void submit() {
    Navigator.of(context).pop(addAmount.text);
  }

  Widget timeLine(int index) {
    billingDate =
        DateTime.utc(now.year, now.month, _listData[index].billingDate);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        popupContainer(
            60.0,
            60.0,
            const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Text("Today"), Text("${now.month}/${now.day}")],
            )),
            radius: 10.0),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          width: 30.0,
          height: 2.0,
          color: primaryColor,
        ),
        popupContainer(
            60.0,
            60.0,
            const EdgeInsets.only(top: 20.0, right: 20.0),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Billing"),
                Text(
                    "${billingMonth(billingDate.day).month}/${(billingDate.day)}")
              ],
            )),
            radius: 10.0),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          width: 30.0,
          height: 2.0,
          color: primaryColor,
        ),
        popupContainer(
            60.0,
            60.0,
            const EdgeInsets.only(top: 20.0, right: 20.0),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Final"),
                Text(
                    "${billingMonth(billingDate.day).add(const Duration(days: 21)).month}/${billingDate.add(const Duration(days: 21)).day}")
              ],
            )),
            radius: 10.0),
      ],
    );
  }

  DateTime billingMonth(int day) {
    if (now.day > day) {
      return now.add(const Duration(days: 30));
    } else {
      return billingDate;
    }
  }

  List<CardDetail> arrangeCards(List<CardDetail> arrangedListData) {
    int count;
    CardDetail card;
    int days1;
    int days2;
    while (true) {
      count = 0;
      for (int i = 0; i < arrangedListData.length - 1; i++) {
        days1 = now
            .difference(DateTime.utc(
                now.year, now.month, arrangedListData[i].billingDate))
            .inDays;
        days2 = now
            .difference(DateTime.utc(
                now.year, now.month, arrangedListData[i + 1].billingDate))
            .inDays;
        if (days1 >= 0 && days2 >= 0) {
          if (days1 > days2) {
            card = arrangedListData[i];
            arrangedListData[i] = arrangedListData[i + 1];
            arrangedListData[i + 1] = card;
            count++;
          }
        }
        if (days1 < 0 && days2 < 0) {
          if (-days2 > -days1) {
            card = arrangedListData[i];
            arrangedListData[i] = arrangedListData[i + 1];
            arrangedListData[i + 1] = card;
            count++;
          }
        }
        if (days1 < 0 && days2 >= 0) {
          card = arrangedListData[i];
          arrangedListData[i] = arrangedListData[i + 1];
          arrangedListData[i + 1] = card;
          count++;
        }
      }
      if (count == 0) {
        break;
      }
    }
    return arrangedListData;
  }
}
