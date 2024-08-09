// import 'package:flutter/material.dart';

// class AnimationColorsContainer extends StatefulWidget {
//   final Widget child;

//   const AnimationColorsContainer({super.key, required this.child});

//   @override
//   State<AnimationColorsContainer> createState() =>
//       _AnimationColorsContainerState();
// }

// class _AnimationColorsContainerState extends State<AnimationColorsContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<AlignmentGeometry> _beginAnimation;
//   late Animation<AlignmentGeometry> _endAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat();

//     _beginAnimation = TweenSequence<AlignmentGeometry>([
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.topLeft,
//           end: Alignment.topRight,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.topRight,
//           end: Alignment.bottomRight,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.bottomRight,
//           end: Alignment.bottomLeft,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.bottomLeft,
//           end: Alignment.topLeft,
//         ),
//         weight: 1,
//       ),
//     ]).animate(_controller);

//     _endAnimation = TweenSequence<AlignmentGeometry>([
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.bottomRight,
//           end: Alignment.bottomLeft,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.bottomLeft,
//           end: Alignment.topLeft,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.topLeft,
//           end: Alignment.topRight,
//         ),
//         weight: 1,
//       ),
//       TweenSequenceItem(
//         tween: AlignmentTween(
//           begin: Alignment.topRight,
//           end: Alignment.bottomRight,
//         ),
//         weight: 1,
//       ),
//     ]).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: _beginAnimation.value,
//               end: _endAnimation.value,
//               colors: [
//                 Colors.brown.withOpacity(0.6),
//                 Colors.brown.withOpacity(0.3),
//                 Colors.white54,
//               ],
//             ),
//           ),
//           child: widget.child,
//         );
//       },
//     );
//   }
// }
