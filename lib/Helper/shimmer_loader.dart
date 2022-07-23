
import 'package:anitask/Helper/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


 class ShimmerList extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: ListView.builder(
         itemCount: 5,
         itemBuilder: (BuildContext context, int index) {
           return Padding(
               padding: EdgeInsets.symmetric(horizontal: 15),
               child: Shimmer.fromColors(
                 highlightColor: Colors.white,
                 baseColor: Colors.black,
                 child: ShimmerLayout(),
               ));
         },
       ),
     );
   }
 }

 class ShimmerLayout extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.symmetric(vertical: 9),
       child:Row(
         children: [
           const Skeleton(height: 120, width: 120),
           const SizedBox(width: defaultPadding),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Skeleton(width: 80),
                 const SizedBox(height: defaultPadding / 2),
                 const Skeleton(),
                 const SizedBox(height: defaultPadding / 2),
                 const Skeleton(),
                 const SizedBox(height: defaultPadding / 2),
                 Row(
                   children: const [
                     Expanded(
                       child: Skeleton(),
                     ),
                     SizedBox(width: defaultPadding),
                     Expanded(
                       child: Skeleton(),
                     ),
                   ],
                 )
               ],
             ),
           )
         ],
       ),
     );
   }
 }

 class Skeleton extends StatelessWidget {
   const Skeleton({Key? key, this.height, this.width}) : super(key: key);

   final double? height, width;

   @override
   Widget build(BuildContext context) {
     return Container(
       height: height,
       width: width,
       padding: EdgeInsets.all(defaultPadding / 2),
       decoration: BoxDecoration(
           color: Colors.black.withOpacity(0.04),
           borderRadius:
           const BorderRadius.all(Radius.circular(defaultPadding))),
     );
   }
 }

 class CircleSkeleton extends StatelessWidget {
   const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

   final double? size;

   @override
   Widget build(BuildContext context) {
     return Container(
       height: size,
       width: size,
       decoration: BoxDecoration(
         color: Theme.of(context).primaryColor.withOpacity(0.04),
         shape: BoxShape.circle,
       ),
     );
   }
 }