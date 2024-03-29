import 'package:flutter/material.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/pages/queue/components/background.dart';
import 'package:queueie/pages/queuenumber/queuenumber_screen.dart';

class QueueBody extends StatefulWidget {
  QueueBody({Key? key, required this.queue}) : super(key: key);
  final queue;
  @override
  State<QueueBody> createState() => _QueueBodyState();
}

class _QueueBodyState extends State<QueueBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("หมายเลขคิวของคุณ", style: TextStyle(fontSize: 20)),
              Card(
                child: SizedBox(
                  width: size.width * 0.65,
                  height: size.height * 0.20,
                  child: Center(
                      child: Text(
                    widget.queue.toString(),
                    style: TextStyle(fontSize: 60),
                  )),
                ),
              )
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.only(top: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text("จำนวนคิวที่รอ", style: TextStyle(fontSize: 20)),
        //       Card(
        //         child: SizedBox(
        //           width: size.width * 0.45,
        //           height: size.height * 0.10,
        //           child: const Center(
        //               child: Text(
        //             "19",
        //             style: TextStyle(fontSize: 35),
        //           )),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        RoundedButton(
            text: "ยกเลิกการจองคิว",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Queuenumber();
              }));
            },
            isLoading: false)
      ],
    ));
  }
}