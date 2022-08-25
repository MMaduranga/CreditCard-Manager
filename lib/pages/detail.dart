import 'package:creditcard_manager/db/database.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController nickName =  TextEditingController();
  TextEditingController billingDate =  TextEditingController();
  TextEditingController currentAmount = TextEditingController();
  TextEditingController  cashLimit= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                AppBar().preferredSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
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
            ),
            child: content(),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 150.0),
        child: FloatingActionButton.extended(
          onPressed: () async{
NotesDatabase().insertDb(idNum, (int)this.nickName., billingDate, currentAmount, cashLimit);

          },
          label: const Text("Add"),
          icon: const Icon(Icons.thumb_up),
        ),
      ),
    );
  }

  Center content() => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  "Lets Get Started!",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'PoppinsSemiBold',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Create a card instance ",
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                textField(
                    const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.pinkAccent,
                    ),
                    "nick name",nickName,
                    keyboardType: TextInputType.text),
                textField(
                    const Icon(
                      Icons.date_range,
                      color: Colors.pinkAccent,
                    ),
                    "Billing Date",billingDate),
                textField(
                    const Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.pinkAccent,
                    ),
                    "purchased amount",currentAmount),
                textField(
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.pinkAccent,
                    ),
                    "cash limit",cashLimit),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      );

 Padding textField(Icon icon, String hint,TextEditingController control,
          {TextInputType keyboardType = TextInputType.number}) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: control,
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.pinkAccent,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.pinkAccent,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
            // hintText: Te
          ),
          keyboardType: keyboardType,
        ),
      );
}
