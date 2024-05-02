// import 'package:flutter/material.dart';

// class BottomNavigationBar extends StatefulWidget {
//   const BottomNavigationBar({super.key});

//   @override
//   State<BottomNavigationBar> createState() => _BottomNavigationBarState();
// }

// class _BottomNavigationBarState extends State<BottomNavigationBar> {
//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:IndexedStack(
//         index: _selectedIndex,
//         children: [
//           FarHomepage(),

//         ],
//       ),
//       bottomNavigationBar: const BottomNavigationBar(

//        [
//       BottomNavigationBarItem(
//         icon: ImageIcon(AssetImage('lib/Images/Home.png')),
//         label: 'Home',

//       ),
//       BottomNavigationBarItem(
//         icon: ImageIcon(AssetImage('lib/Images/Ai.png')),
//         label: 'AI',
//       ),
//       BottomNavigationBarItem(
//         icon: ImageIcon(AssetImage('lib/Images/logo message.png')),
//         label: 'Message',
//       ),
//       BottomNavigationBarItem(
//         icon: ImageIcon(AssetImage('lib/Images/notification.png')),
//         label: 'Notifications',
//       ),
//       BottomNavigationBarItem(
//         icon: ImageIcon(AssetImage('lib/Images/Users.png')),
//         label: 'Profile',
//       ),
//      ],
//      ),
//     );
//   }
// }

import 'package:agron/ai.dart';
import 'package:agron/cart.dart';
import 'package:agron/farhomepage.dart';
import 'package:agron/farmerprofile.dart';
import 'package:agron/message.dart';
import 'package:agron/notification.dart';
import 'package:agron/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  final _pages = [
    const FarHomepage(),
     AiPage(),
     MessagePage(),
    const NotificationPage(),
    const FarmerProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexchangenotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavWidget()),
      ),
      
    );
  }
}

ValueNotifier<int> indexchangenotifier = ValueNotifier(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexchangenotifier,
      builder: (
        context,
        newindex,
        _,
      ) {
        return BottomNavigationBar(
          currentIndex: newindex,
          onTap: (index) {
            indexchangenotifier.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: const Color.fromARGB(255, 11, 11, 11),
          unselectedItemColor: const Color.fromARGB(255, 17, 17, 17),
          selectedIconTheme: const IconThemeData(color: Colors.amber),
          unselectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 2, 49, 18)),
          items:  [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('lib/Images/Home.png')),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 10,
                child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/Images/Ai.png'))),),
                 ),
              label: "Ai",
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 13,
                child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/Images/logo message.png'))),),
                 ),
              label: "Message",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('lib/Images/notification.png')),
              label: "Notification",
            ),
            BottomNavigationBarItem(
             icon: ImageIcon(AssetImage('lib/Images/Users.png')),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}
