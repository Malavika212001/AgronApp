import 'package:agron/paymentsuccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF013220), Colors.black, Colors.white.withOpacity(0)],
    ),
    ),
    child: SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 100,),
          Image.asset('lib/Images/Frame 1.png',height: 100,width: 100,),
          const SizedBox(height: 25,),
          Text(
                'Agron',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: 'Sedgwick Ave Display',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(height: 25,),
             GestureDetector(
               child: Container(
                      width: 335,
                      height: 58,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Specify the border color here
                            width: 2, // Specify the border width here
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "lib/Images/gpay.png",
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Gpay",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
      );
                   }, 
             ), 
                  const SizedBox(height: 15,),
             GestureDetector(
               child: Container(
                      width: 335,
                      height: 58,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Specify the border color here
                            width: 2, // Specify the border width here
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "lib/Images/paytm.png",
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "PayTm",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
      );
                   }, 
             ),
                  const SizedBox(height: 15,),
             GestureDetector(
               child: Container(
                      width: 335,
                      height: 58,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Specify the border color here
                            width: 2, // Specify the border width here
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "lib/Images/phonepe.png",
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "PhonePe",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
      );
                   }, 
             ),
                  const SizedBox(height: 15,),
             GestureDetector(
               child: Container(
                      width: 335,
                      height: 58,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Specify the border color here
                            width: 2, // Specify the border width here
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Center(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 90,
                            ),
                            const Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
      );
                   }, 
             ), 
   ],
      ),
    ),
    ),
      ),
    );
  }
}