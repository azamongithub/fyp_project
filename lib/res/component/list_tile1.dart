import 'package:flutter/material.dart';

class ListTile1 extends StatelessWidget {
  final String title;
  final Widget trailing;

  const ListTile1(
      {Key? key,
        required this.title,
        required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: trailing,
        ),
        Divider(color: Colors.grey.withOpacity(0.6)),
      ],
    );
  }
}




//Not Important
// child: StreamBuilder(
//   stream: ref(user.uid.toString()),
//   builder: (context, AsyncSnapshot snapshot) {
//     if(!snapshot.hasData){
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     else {
//       Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 130,
//             width: 130,
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                     color: Colors.grey,
//                     width: 3
//                 )
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image(
//                   image: NetworkImage(
//                       'https://img.freepik.com/free-photo/happy-business-afro-american-man-standing-smiling-against-blue-background-profile-view_155003-15255.jpg'),
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return CircularProgressIndicator();
//                   },
//                   errorBuilder: (context, object, stack) {
//                     return Container(
//                       child: Icon(
//                         Icons.error_outline,
//                         color: Colors.red,
//                       ),
//                     );
//                   }),
//             ),
//           )
//         ],
//       );
//     }
//   }
// )