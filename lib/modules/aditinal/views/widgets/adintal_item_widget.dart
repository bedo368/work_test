import 'package:flutter/material.dart';

class AditinalItemWedget extends StatelessWidget {
  const AditinalItemWedget(
      {super.key,
      required this.title,
      required this.refNo,
      required this.payment,
      required this.stage});
  final String title;
  final String refNo;
  final String payment;
  final String stage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: Text(title)),
          SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: Text(refNo)),
          SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: Text(payment == '0' ? 'No' : payment)),
          SizedBox(
              width: MediaQuery.of(context).size.width * .2, child: Text(stage))
        ],
      ),
    );
  }
}


class PinedAdinalList extends StatelessWidget {
  const PinedAdinalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      title: const AditinalItemWedget(
        title: '#',
        refNo: 'refNo',
        payment: 'payment',
        stage: 'stage',
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
