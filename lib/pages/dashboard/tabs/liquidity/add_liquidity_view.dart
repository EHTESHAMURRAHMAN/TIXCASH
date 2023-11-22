import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'liquidity_controller.dart';

class AddLiquidityView extends  GetView<LiquidityController>  {
  const AddLiquidityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Liquidity')
      // ),
      body: SafeArea(child: Column(

        children: [
        _appBar(context),
        const Padding(padding: EdgeInsets.symmetric(vertical: 40),
        child: Divider(color: Colors.white24,),),
          _selectPair(context),
          _warningView()

      ],)),
    );
  }

  _appBar(context) => Container(
    // color: Theme.of(context).primaryColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, size: 24,)),
          const SizedBox(width: 8,),

          Row(children: [
            Text('Your Liquidity',style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700)),
            // const Expanded(child: SizedBox())
          ],),
        ],),

        Padding(padding: const EdgeInsets.only(left: 48),
          child: Text('Receive LP Token and earn 0.17% trading fee',style: GoogleFonts.roboto(
              fontSize: 13, color: Colors.white,
              fontWeight: FontWeight.w400)),),
      ],

    ),
  );

  _selectPair(context) => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text('Choose a valid pair',style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w700)),
        const SizedBox(height: 24,),
        Row(children: const [
          Expanded(child: SelectCurrency(title: 'BTC', logo: 'btc',)),
          Icon(Icons.add, size: 24,),
          Expanded(child: SelectCurrency(title: 'BNB', logo: 'bnb',)),
        ],),

        const SizedBox(height: 24,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(children: [
          Expanded(child: Text('LP Reward APR',style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700)),),
          Text('1.80%',style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w700)),
        ],),),

        const Divider(color: Colors.white24,),

        Container(
          // color: Colors.grey[800],
          child: GestureDetector(onTap: () => Get.to(const AddLiquidityView()), child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            alignment: Alignment.center,
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add, size: 24,),
                const SizedBox(width: 8,),
                Text('Add Liquidity',style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500) )
              ],),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8)),
          )),
        )

    ],),
  );

  _warningView() => Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

    child:  Text('By adding liquidity you will earn 0.17% of all trade on this pair proportional to you shares of pool.'
        'Fee are added to the pool accurate in real time and can be claimed by withdrawing your liquidity',
        style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w300)),

    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(8),
    ),

  );

}

class SelectCurrency extends StatelessWidget {
  final String title;
  final String logo;
  const SelectCurrency({Key? key, required this.title, required this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PopupMenuButton<String>(
        onSelected: (String value) {
          // setState(() {
          //   _selection = value;
          // });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          height: 50,
          width: double.infinity,
          child: Row(children: [
            Image.asset('assets/icon/$logo@2x.png'),
            const SizedBox(width: 8,),
            Expanded(child: Text(title, style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500))),
            const Icon(Icons.arrow_drop_down, size: 24,)
          ],),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).primaryColor)
          ),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Value1',
            child: Text('Choose value 1'),
          ),
          const PopupMenuItem<String>(
            value: 'Value2',
            child: Text('Choose value 2'),
          ),
          const PopupMenuItem<String>(
            value: 'Value3',
            child: Text('Choose value 3'),
          ),
        ],
      ),
      const SizedBox(height: 4,),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Expanded(child: Text('Balance', style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400))),
        Text('0.234145', style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500))
      ],),),

      Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Expanded(child: Text('', style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w400))),
          Text('\$0.23', style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500))
        ],),)

    ],);
  }
}

  