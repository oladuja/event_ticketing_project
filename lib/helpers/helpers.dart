// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:studhad/components/app_avatar.dart';
// import 'package:studhad/components/app_icon_button.dart';
// import 'package:studhad/components/app_textfields.dart';
// import 'package:studhad/components/buttons.dart';
// import 'package:studhad/helpers/extensions.dart';
//
//
// class DrawerItems extends StatelessWidget {
//    const DrawerItems({
//     super.key,
//     this.text,
//     this.onTap,
//     this.paddingHorizontal,
//     this.backgroundColor,
//     this.textColor,
//     this.fontSize,
//   }) ;
//
//   final String? text;
//   final Function()? onTap;
//   final double? paddingHorizontal;
//   final double? fontSize;
//   final Color? backgroundColor;
//   final Color? textColor;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: backgroundColor ?? Colors.transparent,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 20, vertical: 5),
//         child: Text(
//           text ?? '',
//           style: TextStyle(
//               fontSize: fontSize ?? 14,
//               color: textColor ?? Colors.black,
//               fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//    const SectionTitle({
//     super.key,
//     this.text,
//     this.buttonText,
//     this.onTap,
//     this.borderColor,
//     this.textColor,
//     this.textSize,
//     this.titleTextSize,
//     this.showSeeMore = true,
//   });
//
//   final String? text;
//   final String? buttonText;
//   final Function()? onTap;
//   final Color? borderColor;
//   final Color? textColor;
//   final double? textSize;
//   final double? titleTextSize;
//   final bool showSeeMore;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           text ?? '',
//           style: TextStyle(
//               fontSize: titleTextSize ?? 17,
//
//               fontWeight: FontWeight.w600,
//               color: context.colorScheme.onSurface
//           ),
//         ),
//          const Spacer(),
//         Visibility(
//           visible: showSeeMore,
//           child: InkWell(
//             onTap: onTap,
//             child: Container(
//               padding: 2.allPadding,
//               width: 55.responsiveWidth,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: borderColor ?? context.colorScheme.primary, width: .5)
//               ),
//               child: Center(
//                 child: Text(
//                   buttonText ?? 'See More',
//                   style: TextStyle(
//                     color: textColor ?? context.colorScheme.primary,
//                     fontSize: textSize ?? 10,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class WinnerItem extends StatelessWidget {
//    const WinnerItem({
//     super.key,
//     this.img,
//     this.name,
//   });
//
//   final String? img;
//   final String? name;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         height: 165,
//         width: 152,
//         decoration: BoxDecoration(
//             color: context.colorScheme.onPrimary,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                   color: context.colorScheme.onSurface.withOpacity(.1),
//                   blurRadius: 5,
//                   spreadRadius: 0,
//                   offset:  const Offset(0, 5)
//               )
//             ]
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//
//           children: [
//             AppAvatar(
//               width: 94,
//               height: 94,
//               backgroundColor: context.colorScheme.primary.withOpacity(.7),
//               imgUrl: img ?? '',
//             ),
//             10.heightBox,
//             Text(
//               name ?? '',
//               style: TextStyle(
//                 fontSize: 12.responsiveText,
//                 fontWeight: FontWeight.w500,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ArticleItem extends StatelessWidget {
//    const ArticleItem({
//     super.key,
//     this.category,
//     this.title,
//     this.name = '',
//     this.articleImg,
//     this.personImg,
//     this.views,
//     this.date,
//     this.onTap,
//   });
//   final String? category;
//   final String? title;
//   final String? name;
//   final String? articleImg;
//   final String? personImg;
//   final String? views;
//   final String? date;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         width: 289,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 AppAvatar(
//                   backgroundColor: context.colorScheme.primary.withOpacity(.7),
//                   width: 289,
//                   height: 176,
//                   radius: 16,
//                   imgUrl: articleImg ?? '',
//                 ),
//
//                 SizedBox(
//                   width: 289,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                         },
//                         child: Container(
//                           padding: 2.allPadding,
//                           width: 57,
//                           height: 24,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: context.colorScheme.onPrimary.withOpacity(.4),
//                               border: Border.all(color: context.colorScheme.onPrimary.withOpacity(.4), width: .5)
//                           ),
//                           child: Center(
//                             child: Text(
//                               category ?? '',
//                               style:  TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 8.responsiveText,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                         },
//                         child: Container(
//                           width: 24,
//                           height: 24,
//                           // padding: 2.allPadding,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               color: context.colorScheme.onPrimary.withOpacity(.4),
//                               border: Border.all(color: context.colorScheme.onPrimary.withOpacity(.4), width: .5)
//                           ),
//                           child: Center(
//                               child: Icon(Icons.bookmark_border_outlined, color: Colors.white.withOpacity(.8),)
//                           ),
//                         ),
//                       )
//                     ],
//                   ).paddingAll(15),
//                 )
//               ],
//             ),
//             10.heightBox,
//             Text(
//               title ?? '',
//               style: TextStyle(
//                 fontSize: 17.responsiveText,
//                 fontWeight: FontWeight.w600,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//             20.heightBox,
//             Row(
//               children: [
//                 AppAvatar(
//                   width: 20,
//                   height: 20,
//                   backgroundColor: context.colorScheme.primary.withOpacity(.7),
//                   radius: 4,
//                   imgUrl: personImg ?? '',
//                 ),
//                 5.widthBox,
//                 Text(
//                   'By: $name',
//                   style: TextStyle(
//                     fontSize: 10.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface.withOpacity(.8),
//                   ),
//                 ),
//                  const Spacer(),
//                 Text(
//                   date ?? '',
//                   style: TextStyle(
//                     fontSize: 10.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface.withOpacity(.8),
//                   ),
//                 ),
//                 3.widthBox,
//                 Text(
//                   '\u2022',
//                   style: TextStyle(
//                     fontSize: 20.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface,
//                   ),
//                 ),
//                 3.widthBox,
//                 Text(
//                   views!,
//                   style: TextStyle(
//                     fontSize: 10.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface.withOpacity(.8),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ArticleListItem extends StatelessWidget {
//    const ArticleListItem({
//     super.key,
//     this.img,
//     this.title,
//     this.date,
//     this.category,
//     this.views,
//     this.onTap,
//   });
//   final String? img;
//   final String? title;
//   final String? date;
//   final String? category;
//   final String? views;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         width: 335,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppAvatar(
//               backgroundColor: context.colorScheme.primary.withOpacity(.7),
//               width: 96,
//               height: 79,
//               radius: 5,
//               imgUrl: img ?? '',
//             ),
//             5.widthBox,
//             Expanded(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 54,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: context.colorScheme.onSurface.withOpacity(.04),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Center(
//                           child: Text(
//                             category ?? '',
//                             style:  TextStyle(
//                               fontSize: 9.responsiveText,
//                               fontWeight: FontWeight.w400
//                             ),
//                           ),
//                         ),
//                       ),
//                        const Spacer(),
//                       Text(
//                         date ?? '',
//                         style: TextStyle(
//                           fontSize: 10.responsiveText,
//                           fontWeight: FontWeight.w400,
//                           color: context.colorScheme.onSurface.withOpacity(.8),
//                         ),
//                       ),
//                       3.widthBox,
//                       Text(
//                         '\u2022',
//                         style: TextStyle(
//                           fontSize: 20.responsiveText,
//                           fontWeight: FontWeight.w400,
//                           color: context.colorScheme.onSurface,
//                         ),
//                       ),
//                       3.widthBox,
//                       Text(
//                         views ?? '',
//                         style: TextStyle(
//                           fontSize: 10.responsiveText,
//                           fontWeight: FontWeight.w400,
//                           color: context.colorScheme.onSurface.withOpacity(.8),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     title ?? '',
//                     style: TextStyle(
//                       fontSize: 17.responsiveText,
//                       fontWeight: FontWeight.w600,
//                       color: context.colorScheme.onSurface,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MissingWordListItem extends StatelessWidget {
//    const MissingWordListItem({
//     super.key,
//     this.title,
//     this.date,
//     this.submission,
//     this.onTap,
//   });
//   final String? title;
//   final String? date;
//   final String? submission;
//   final Function()? onTap;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         // width: 346,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title ?? '',
//               style: TextStyle(
//                 fontSize: 17.responsiveText,
//                 fontWeight: FontWeight.w600,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//             15.heightBox,
//             Row(
//               children: [
//                 Text(
//                   date ?? '',
//                   style: TextStyle(
//                     fontSize: 10.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface.withOpacity(.8),
//                   ),
//                 ),
//                  const Spacer(),
//                 Text(
//                   '$submission submissions',
//                   style: TextStyle(
//                     fontSize: 10.responsiveText,
//                     fontWeight: FontWeight.w400,
//                     color: context.colorScheme.onSurface.withOpacity(.8),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ContactUsForm extends StatelessWidget {
//    const ContactUsForm({
//     super.key,
//     this.hintText,
//     this.keyboardType,
//     this.maxLines,
//     this.fontSize = 12,
//     this.controller,
//     this.validator,
//   });
//
//   final String? hintText;
//   final TextInputType? keyboardType;
//   final int? maxLines;
//   final double fontSize;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: TextFormField(
//         validator: validator,
//         keyboardType: keyboardType,
//         controller: controller,
//         maxLines: maxLines ?? 1,
//         cursorColor: context.colorScheme.onSurface,
//         cursorWidth: 1,
//         style: TextStyle(
//           color: context.colorScheme.onSurface,
//           fontSize: 12.responsiveText,
//         ),
//         decoration: InputDecoration(
//           contentPadding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           hintText: hintText ?? '',
//           hintStyle: TextStyle(
//             color: context.colorScheme.onSurface.withOpacity(.5),
//             fontSize: fontSize,
//           ),
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//               width: 1.0,
//             ),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//               width: 1.0,
//             ),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//               width: 1.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class NotificationItem extends StatelessWidget {
//    const NotificationItem({
//     super.key,
//     this.text,
//     this.time,
//   });
//   final String? text;
//   final String? time;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 346,
//       height: 82,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children:[
//           Text(
//             text ?? '',
//             style: TextStyle(
//               fontSize: 17.responsiveText,
//               fontWeight: FontWeight.w600,
//               color: context.colorScheme.onSurface,
//             ),
//           ),
//           7.heightBox,
//           Text(
//             time ?? '',
//             style: TextStyle(
//               fontSize: 10.responsiveText,
//               fontWeight: FontWeight.w400,
//               color: context.colorScheme.onSurface.withOpacity(.8),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WalletIcon extends StatelessWidget {
//    const WalletIcon({
//     super.key,
//     this.img,
//     this.text,
//     this.onTap,
//   });
//
//   final String? img;
//   final String? text;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Image.asset(img ?? '', width: 12, height: 12,),
//           10.heightBox,
//           Text(
//             text ?? '',
//             style: GoogleFonts.sora(
//                 textStyle:  TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12.responsiveText,
//                   color: Colors.white,
//                 )
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WalletText extends StatefulWidget {
//    const WalletText({
//     super.key,
//     this.balance = 0,
//   });
//   final double? balance;
//
//   @override
//   State<WalletText> createState() => _WalletTextState();
// }
//
// class _WalletTextState extends State<WalletText> {
//   String _normalBalance = '0';
//
//
//   String _trailingNormalBalance = '00';
//
//   @override
//   void initState() {
//     super.initState();
//     if((widget.balance?.toString() ?? "").contains(".")){
//       _normalBalance = (widget.balance?.toString() ?? "").split(".")[0];
//       _trailingNormalBalance = (widget.balance?.toStringAsFixed(2).toString() ?? "").split(".")[1];
//     }else{
//       _normalBalance = (widget.balance?.toString() ?? "");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Text.rich(
//       TextSpan(
//         text: _normalBalance.currency(),
//         style: GoogleFonts.sora(
//           textStyle:  const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 36,
//             color: Colors.white,
//           ),
//         ),
//         children: [
//           TextSpan(
//             text: ".${_trailingNormalBalance.padLeft(2, '0')}",
//             style: GoogleFonts.sora(
//                 textStyle:  const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                   color: Colors.white,
//                 )
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class TransactionItem extends StatelessWidget {
//    const TransactionItem({
//     super.key,
//     this.isCredit = "credit",
//     this.title,
//     this.time,
//     this.amount,
//   });
//   final String? isCredit;
//   final String? title;
//   final String? time;
//   final double? amount;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       minTileHeight: 20,
//       contentPadding:  const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
//       shape: UnderlineInputBorder(
//         borderSide: BorderSide(
//           color: context.colorScheme.onSurface.withOpacity(.1),
//           width: 1.0,
//         ),
//       ),
//       leading: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//           color:  const Color(0xFFE6DDFF),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//             child: Image.asset(
//               isCredit == "credit" || isCredit == "deposit"  ? 'assets/images/upload.png' : 'assets/images/download.png',
//               width: 12, height: 12,
//               color: isCredit == "credit" || isCredit == "deposit" ?  const Color(0xFF191919) :  const Color(0xFFB83232),
//             )
//         ),
//       ),
//       title: Text(
//         title ?? '',
//         style: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 13.responsiveText,
//           color: context.colorScheme.onSurface,
//         ),
//       ),
//       subtitle: Text(
//         "$time ago",
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 12.responsiveText,
//           color: context.colorScheme.onSurface.withOpacity(.5),
//         ),
//       ),
//       trailing: SizedBox(
//         width: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               '${isCredit == "credit" || isCredit == "deposit" ? '+' : '-'}${amount?.toStringAsFixed(2).padRight(2, '0')}',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12.responsiveText,
//                 color: isCredit == "credit" || isCredit == "deposit" ?  const Color(0xFF289B4F) :  const Color(0xFFB83232),
//               ),
//             ),
//             5.widthBox,
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               size: 10,
//               color: context.colorScheme.onSurface,
//             ),
//           ],
//         ),
//       ),
//     ).paddingSymmetric(horizontal: 25);
//   }
// }
//
// class MissingWordDialog extends StatelessWidget {
//    const MissingWordDialog({
//     super.key,
//     this.title,
//     this.hintText,
//     this.buttonText,
//     this.onPressed,
//     this.onPressedSend,
//     this.showButton = false,
//     this.showChild = true,
//     this.isLoading = false,
//     this.keyboardType,
//     this.controller,
//     this.child,
//     this.validator,
//     this.formKey,
//   });
//
//   final String? title;
//   final String? hintText;
//   final String? buttonText;
//   final Function()? onPressed;
//   final Function()? onPressedSend;
//   final bool showButton;
//   final bool showChild;
//   final bool isLoading;
//   final TextInputType? keyboardType;
//   final TextEditingController? controller;
//   final Widget? child;
//   final String? Function(String?)? validator;
//   final Key? formKey;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//           child: Container(
//             padding: 10.horizontalPadding.copyWith(top: 20, bottom: 20),
//             // height: showButton ? 240 : 195,
//             // width: 350,
//             decoration: BoxDecoration(
//               color:  const Color(0xFFF2F2F2).withOpacity(.9),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   5.heightBox,
//
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           Get.back();
//                         },
//                         child: Container(
//                           width: 20,
//                           height: 20,
//                           decoration: BoxDecoration(
//                             color: context.colorScheme.primary.withOpacity(.5),
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Center(child: Icon(Icons.close_outlined, color: Colors.black.withOpacity(.7), size: 14,)),
//                         ),
//                       ),
//                        const Spacer(),
//                       Text(
//                         title ?? '',
//                         style:  TextStyle(
//                           fontSize: 14.responsiveText,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black
//                         ),
//                       ),
//                     ],
//                   ).paddingSymmetric(horizontal: 10),
//                   30.heightBox,
//                   Container(
//                     padding: 20.horizontalPadding,
//                     height: 80,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: AppTextField(
//                               validator: validator,
//                               controller: controller,
//                               keyboardType: keyboardType,
//                               hint: hintText ?? '',
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               borderColor: Colors.black.withOpacity(.8),
//                               textStyle:  TextStyle(
//                                 fontSize: 12.responsiveText,
//                                 color: Colors.black
//                               ),
//
//                             ),
//                           ),
//                         ),
//                         5.widthBox,
//                         Visibility(
//                           visible: showButton ? false : true,
//                           child: isLoading ?  const SizedBox(width:20, height:20,child: CircularProgressIndicator(strokeWidth: 2,)) :IconButton(
//                             onPressed: onPressedSend,
//                             iconSize: 30,
//                             icon: Icon(
//                               Icons.send,
//                               color: context.colorScheme.primary.withOpacity(.7),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   20.heightBox,
//                   Visibility(
//                     visible: showButton,
//                     child: Center(
//                       child: AppButton(
//                         onPressed: onPressed,
//                         title: buttonText ?? '',
//                         width: 196,
//                         height: 38,
//                         borderRadius: 16,
//                         backgroundColor: context.colorScheme.primary.withOpacity(.7),
//                         borderColor: context.colorScheme.primary.withOpacity(.7),
//                         textStyle: GoogleFonts.openSans(
//                             textStyle: TextStyle(
//                               fontSize: 13.responsiveText,
//                               fontWeight: FontWeight.w700,
//                               color: context.colorScheme.onPrimary,
//                             )
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//       );
//   }
// }
//
// class Group extends StatelessWidget {
//    const Group({
//     super.key,
//     this.imgUrl,
//     this.title,
//     this.members,
//     this.posts,
//     this.isMember = false,
//     this.onTap,
//     this.onTapGroup,
//   });
//
//   final String? imgUrl;
//   final String? title;
//   final String? members;
//   final String? posts;
//   final bool isMember;
//   final Function()? onTap;
//   final Function()? onTapGroup;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(Get.context!).size.width;
//     return InkWell(
//       onTap: onTapGroup,
//       child: SizedBox(
//         // width: 36,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             AppAvatar(
//               width: 50,
//               height: 50,
//               radius: 4,
//               imgUrl: imgUrl ?? '',
//             ),
//             10.widthBox,
//             SizedBox(
//               width: width < 420 ? 170 : 220,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title ?? '',
//                     style: GoogleFonts.sora(
//                         textStyle:  const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 11,
//                         )
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         members ?? '',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: context.colorScheme.onSurface.withOpacity(.8),
//                         ),
//                       ),
//                        const Spacer(),
//                       Text(
//                         posts ?? '',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: context.colorScheme.onSurface.withOpacity(.8),
//                         ),
//                       ).withPadding(right: 20),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//
//              const Spacer(),
//             InkWell(
//               onTap: onTap,
//               child: Container(
//                 padding: 5.allPadding,
//                 width: 50.responsiveWidth,
//                 decoration: BoxDecoration(
//                   color: context.colorScheme.primary.withOpacity(.7),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: Center(
//                   child: Text(
//                     isMember ? 'Joined' : 'Join',
//                     style: TextStyle(
//                       color: context.colorScheme.onPrimary,
//                       fontSize: 12.responsiveText,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MoreItem extends StatelessWidget {
//    const MoreItem({
//     super.key,
//     this.title,
//     this.icon,
//     this.onTap,
//   });
//
//   final String? title;
//   final IconData? icon;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 44,
//       child: ListTile(
//         onTap: onTap,
//         leading: Container(
//           width: 27,
//           height: 27,
//           decoration: BoxDecoration(
//             color: context.colorScheme.secondary.withOpacity(.15),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               color: context.colorScheme.primary.withOpacity(.7),
//               size: 18,
//             ),
//           ),
//         ),
//         title: Text(
//           title ?? '',
//         ),
//         titleTextStyle: TextStyle(
//           fontWeight: FontWeight.w600,
//           fontSize: 14.responsiveText,
//           color: context.colorScheme.onSurface,
//         ),
//       ),
//     ).paddingOnly(left: 10);
//   }
// }
//
// class LongText extends StatelessWidget {
//    const LongText({
//     super.key,
//     this.text,
//     this.fontSize,
//     this.height,
//     this.textStyle,
//   });
//   final String? text;
//   final double? fontSize;
//   final double? height;
//   final TextStyle? textStyle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//         text ?? '',
//         style: textStyle ?? GoogleFonts.openSans(
//           textStyle: TextStyle(
//             fontSize: fontSize,
//             fontWeight: FontWeight.w400,
//             height: height,
//             color: context.colorScheme.onSurface.withOpacity(.8),
//           ),
//         )
//     );
//   }
// }
//
// class PostItem extends StatefulWidget {
//   const PostItem({
//     super.key,
//     this.time,
//     this.content,
//     this.name,
//     this.imgUrl,
//     this.likes,
//     this.comments,
//     this.shares,
//     this.isLiked = false,
//     this.isUser = false,
//     this.onTap,
//     this.onTapLikeBtn,
//     this.onTapShareBtn,
//     this.onTapPopUpBtn,
//     this.viewUserProfile,
//     required this.items
//   });
//
//   final String? time;
//   final String? content;
//   final String? name;
//   final String? imgUrl;
//   final String? likes;
//   final String? comments;
//   final String? shares;
//   final List<String> items;
//   final bool isLiked;
//   final bool isUser;
//   final Function()? onTap;
//   final Function()? onTapLikeBtn;
//   final Function()? onTapShareBtn;
//   final Function()? viewUserProfile;
//   final String? Function(String?)? onTapPopUpBtn;
//
//
//   @override
//   State<PostItem> createState() => _PostItemState();
// }
//
// class _PostItemState extends State<PostItem> {
//   @override
//   Widget build(BuildContext context) {
//     // get screen width
//     final width = MediaQuery.of(Get.context!).size.width;
//     return Container(
//       padding: 20.horizontalPadding,
//       decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//             ),
//           )
//       ),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: widget.viewUserProfile,
//                     child: AppAvatar(
//                       radius: 50,
//                       width: 32,
//                       height: 32,
//                       backgroundColor: context.colorScheme.primary.withOpacity(.7),
//                       imgUrl: widget.imgUrl ?? '',
//                     ),
//                   ),
//                   10.widthBox,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: widget.viewUserProfile,
//                         child: Text(
//                             widget.name ?? '',
//                             style: TextStyle(
//                               color: context.colorScheme.onSurface,
//                               fontSize: 13.responsiveText,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                       ),
//                       Text(
//                         widget.time ?? '',
//                         style: TextStyle(
//                           color: context.colorScheme.onSurface.withOpacity(.5),
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                    const Spacer(),
//                   PopupMenuButton(
//                     color: context.colorScheme.surface,
//                     onSelected: widget.onTapPopUpBtn,
//                     itemBuilder: (context) {
//                       return widget.isUser
//                           ? widget.items.map((String item) {
//                         return PopupMenuItem(
//                           value: item,
//                           height: 36,
//                           child: Text(
//                             item,
//                             style: GoogleFonts.inter(
//                                 textStyle: TextStyle(
//                                   backgroundColor: context.colorScheme.surface,
//                                   fontSize: 14.responsiveText,
//                                   fontWeight: FontWeight.w400,
//                                   color: context.colorScheme.onSurface.withOpacity(.7),
//                                 )
//                             ),
//                           ),
//                         );
//                       }).toList() :
//                           ["Report Post"].map((String item) {
//                             return PopupMenuItem(
//                               value: item,
//                               height: 36,
//                               child: Text(
//                                 item,
//                                 style: GoogleFonts.inter(
//                                     textStyle: TextStyle(
//                                       backgroundColor: context.colorScheme.surface,
//                                       fontSize: 14.responsiveText,
//                                       fontWeight: FontWeight.w400,
//                                       color: context.colorScheme.onSurface.withOpacity(.7),
//                                     )
//                                 ),
//                               ),
//                             );
//                           }).toList();
//                     },
//                     child: Icon(
//                       Icons.more_horiz,
//                       color: context.colorScheme.onSurface,
//                       size: 17,
//                       // backgroundColor: Colors.transparent,
//                     ),
//                   ),
//                 ],
//               ),
//               10.heightBox,
//               LongText(
//                 text: widget.content ?? '',
//                 fontSize: 14.responsiveText,
//                 height: 1.5,
//                 textStyle: TextStyle(
//                   fontSize: 14.responsiveText,
//                   fontWeight: FontWeight.w400,
//                   color: context.colorScheme.onSurface,
//                   height: 1.5,
//                 ),
//               ),
//               20.heightBox,
//               if(width < 420)...{
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           widget.likes ?? '',
//                           style: TextStyle(
//                             color: context.colorScheme.onSurface,
//                             fontSize: 14.responsiveText,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         5.widthBox,
//                         AppIconButton(
//                           icon: widget.isLiked ? Icons.thumb_up_alt_sharp : Icons.thumb_up_alt_outlined,
//                           iconSize: 18,
//                           iconColor: context.colorScheme.onSurface.withOpacity(.5),
//                           backgroundColor: Colors.transparent,
//                           width: 18,
//                           height: 18,
//                           onPressed: widget.onTapLikeBtn,
//                         ),
//                       ],
//                     ),
//                     10.widthBox,
//                     InkWell(
//                       onTap: widget.onTap,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           AppIconButton(
//                             icon: Icons.comment_outlined,
//                             iconSize: 18,
//                             iconColor: context.colorScheme.onSurface.withOpacity(.5),
//                             backgroundColor: Colors.transparent,
//                             width: 18,
//                             height: 18,
//                             onPressed: (){},
//                           ),
//                           5.widthBox,
//                           Text(
//                             widget.comments ?? '',
//                             style: TextStyle(
//                               color: context.colorScheme.onSurface,
//                               fontSize: 14.responsiveText,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               }
//               else...{
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           widget.likes ?? '',
//                           style: TextStyle(
//                             color: context.colorScheme.onSurface,
//                             fontSize: 16.responsiveText,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         5.widthBox,
//                         AppIconButton(
//                           icon: widget.isLiked ? Icons.thumb_up_alt_sharp : Icons.thumb_up_alt_outlined,
//                           iconSize: 18,
//                           iconColor: context.colorScheme.onSurface.withOpacity(.5),
//                           backgroundColor: Colors.transparent,
//                           width: 20,
//                           height: 20,
//                           onPressed: widget.onTapLikeBtn
//                         ),
//                       ],
//                     ),
//                     40.widthBox,
//                     InkWell(
//                       onTap: widget.onTap,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           AppIconButton(
//                             icon: Icons.comment_outlined,
//                             iconSize: 18,
//                             iconColor: context.colorScheme.onSurface.withOpacity(.5),
//                             backgroundColor: Colors.transparent,
//                             width: 20,
//                             height: 20,
//                             onPressed: (){},
//                           ),
//                           5.widthBox,
//                           Text(
//                             widget.comments ?? '',
//                             style: TextStyle(
//                               color: context.colorScheme.onSurface,
//                               fontSize: 16.responsiveText,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     20.widthBox,
//                   ],
//                 ),
//               },
//               10.heightBox,
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class GroupMember extends StatelessWidget {
//    const GroupMember({
//     super.key,
//     this.name,
//     this.joinedDate,
//     this.imgUrl,
//     this.btnText = 'Follow',
//     this.onTap,
//     this.onPictureTap,
//     this.isFollowing = false,
//     this.isUser = true,
//   });
//
//   final String? name;
//   final String? joinedDate;
//   final String? imgUrl;
//   final String? btnText;
//   final Function()? onTap;
//   final Function()? onPictureTap;
//   final bool isFollowing;
//   final bool isUser;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(Get.context!).size.width;
//     return Padding(
//       padding:  const EdgeInsets.symmetric(horizontal: 10),
//       child: SizedBox(
//         height: 50,
//         child: ListTile(
//           leading: InkWell(
//             onTap: onPictureTap,
//             child: AppAvatar(
//               width: width < 420 ? 40 :50,
//               height:width < 420 ? 40 :50,
//               radius: 50,
//               backgroundColor: context.colorScheme.primary.withOpacity(.7),
//               imgUrl: imgUrl ?? '',
//             ),
//           ),
//           title: Text(
//             name ?? '',
//             style: TextStyle(
//               color: context.colorScheme.onSurface,
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           subtitle: Text(
//             joinedDate ?? '',
//             style: TextStyle(
//               color: context.colorScheme.onSurface.withOpacity(.5),
//               fontSize: 11,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           trailing: Visibility(
//             visible: isUser,
//             child: InkWell(
//               onTap: onTap,
//               child: Container(
//                 width: width < 420 ? (isFollowing ? 67 : 67) : (isFollowing ? 84 : 67),
//                 height: 28,
//                 decoration: BoxDecoration(
//                   color: context.colorScheme.primary.withOpacity(.7),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Center(
//                   child: Text(
//                     isFollowing ? 'Following' : 'Follow',
//                     style: TextStyle(
//                       color: context.colorScheme.surface,
//                       fontSize: width < 420 ? 10 : 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PromotionItem extends StatelessWidget {
//    const PromotionItem({
//     super.key,
//     this.status,
//     this.name,
//     this.date,
//     this.imgUrl,
//     this.onTap,
//   });
//   final String? status;
//   final String? name;
//   final String? date;
//   final String? imgUrl;
//   final Function()? onTap;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(Get.context!).size.width;
//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           AppAvatar(
//             width: 50,
//             height: 50,
//             radius: 4,
//             backgroundColor: context.colorScheme.primary.withOpacity(.7),
//             imgUrl: imgUrl ?? '',
//           ),
//           10.widthBox,
//           SizedBox(
//             width: width < 420 ? 130 : 200,
//               child: AppColumnText(name: name, date: date)),
//            const Spacer(),
//
//           if(status == 'running')...{
//              const PromotionButton(
//               backgroundColor: Color(0xFF6C2A0C),
//               text: 'Running',
//             ),
//           } else if(status == 'completed')...{
//              const PromotionButton(
//               backgroundColor: Color(0xFF34C759),
//               text: 'Completed',
//             ),
//           }else if(status == 'inreview')...{
//             PromotionButton(
//               backgroundColor: context.colorScheme.primary.withOpacity(.7),
//               text: 'Inreview',
//             ),
//           } else...{ const PromotionButton()}
//
//         ],
//       ),
//     );
//   }
// }
//
// class AppColumnText extends StatelessWidget {
//    const AppColumnText({
//     super.key,
//     this.name,
//     this.date,
//     this.fontWeight,
//     this.fontSize,
//     this.showSubText = true,
//     this.crossAxisAlignment,
//     this.subTextColor,
//     this.textStyle,
//   });
//
//   final String? name;
//   final String? date;
//   final FontWeight? fontWeight;
//   final double? fontSize;
//   final bool showSubText;
//   final CrossAxisAlignment? crossAxisAlignment;
//   final Color? subTextColor;
//   final TextStyle? textStyle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
//       children: [
//         Text(
//           name ?? '',
//           style: textStyle ?? TextStyle(
//             color: context.colorScheme.onSurface,
//             fontSize: fontSize ?? 14,
//             fontWeight: fontWeight ?? FontWeight.w700,
//           ),
//         ),
//         Visibility(
//           visible: showSubText,
//           child: Text(
//             date ?? '',
//             style: TextStyle(
//               color: subTextColor ?? context.colorScheme.onSurface.withOpacity(.5),
//               fontSize: 11,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class PromotionButton extends StatelessWidget {
//    const PromotionButton({
//     super.key,
//     this.text,
//     this.backgroundColor,
//     this.onTap,
//   });
//   final String? text;
//   final Color? backgroundColor;
//   final Function()? onTap;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: 15.horizontalPadding,
//         // width: 54,
//         height: 28,
//         decoration: BoxDecoration(
//           color: backgroundColor ?? context.colorScheme.primary.withOpacity(.7),
//           borderRadius: BorderRadius.circular(2),
//         ),
//         child: Center(
//           child: Text(
//             text ?? 'pending',
//             style: TextStyle(
//               color: context.colorScheme.onPrimary,
//               fontWeight: FontWeight.w700,
//               fontSize: 11,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AppBtn extends StatelessWidget {
//    const AppBtn({
//     super.key,
//     this.onTap,
//     this.text,
//     this.backgroundColor,
//   });
//
//   final Function()? onTap;
//   final String? text;
//   final Color? backgroundColor;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         decoration: BoxDecoration(
//           color: backgroundColor ?? context.colorScheme.primary.withOpacity(.7),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Center(
//           child: Text(
//             text ?? '',
//             style:  TextStyle(
//               color: Colors.white,
//               fontSize: 12.responsiveText,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProfileBanner extends StatefulWidget {
//    const ProfileBanner({
//     super.key,
//     this.showEditImg = false,
//     this.imgUrl,
//     this.pickFile,
//     this.imageFile,
//   });
//
//   final bool showEditImg;
//   final String? imgUrl;
//   final File? imageFile;
//   final Function()? pickFile;
//
//   @override
//   State<ProfileBanner> createState() => _ProfileBannerState();
// }
//
// class _ProfileBannerState extends State<ProfileBanner> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ClipPath(
//           clipper: Clipper(),
//           child: Container(
//             height: 258,
//             width: double.infinity,
//             decoration:  const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFFEAA56B),
//                   Color(0xFFEAA56B),
//                   Color(0xFFEB7D4B),
//                 ],
//               ),
//               //   bottom border is curved in the center
//
//             ),
//           ),
//         ),
//         Column(
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: (){Get.back();},
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         color: context.colorScheme.onSurface.withOpacity(.5),
//                       ),
//                     ),
//                      const Spacer(),
//                      AppColumnText(
//                       name: 'Profile',
//                       fontSize: 17.responsiveText,
//                       fontWeight: FontWeight.w600,
//                     ).paddingOnly(right: 180,),
//
//                   ],
//                 ),
//               ),
//             ),
//             Stack(
//               children: [
//                 AppAvatar(
//                   width: 108,
//                   height: 108,
//                   borderColor:  const Color(0xFFE4C885),
//                   borderWidth: 4,
//                   imgUrl: widget.imgUrl ?? '',
//                   imageFile: widget.imageFile,
//                 ),
//                 Visibility(
//                   visible: widget.showEditImg,
//                   child: Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: widget.pickFile,
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration:  const BoxDecoration(
//                           color: Color(0xFF6C2A0C),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.edit_outlined,
//                             color: context.colorScheme.onPrimary,
//                             size: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
//
// class Clipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0.0, size.height);
//     path.quadraticBezierTo(
//         size.width / 2,
//         size.height - 100,
//         size.width,
//         size.height
//     );
//     path.lineTo(size.width, 0.0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class MessageItem extends StatelessWidget {
//    const MessageItem({
//     super.key,
//     this.imgUrl,
//     this.name,
//     this.message,
//     this.isOnline = false,
//     this.onTap,
//   });
//
//   final String? imgUrl;
//   final String? name;
//   final String? message;
//   final bool isOnline;
//   final Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border(
//             top: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//             ),
//             bottom: BorderSide(
//               color: context.colorScheme.onSurface.withOpacity(.1),
//             ),
//           ),
//           color: context.colorScheme.surface,
//           boxShadow: [
//             BoxShadow(
//               color: context.colorScheme.onSurface.withOpacity(0.05),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset:  const Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 AppAvatar(
//                   width: 37,
//                   height: 37,
//                   radius: 50,
//                   backgroundColor: context.colorScheme.primary.withOpacity(.7),
//                   borderColor: Colors.transparent,
//                   imgUrl: imgUrl ?? '',
//                 ),
//                 Visibility(
//                   visible: isOnline,
//                   child: Positioned(
//                     bottom: 2,
//                     right: 2,
//                     child: Container(
//                       width: 7,
//                       height: 7,
//                       decoration: BoxDecoration(
//                         color:  const Color(0xFF56DE53),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white,
//                           width: .5,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             10.widthBox,
//             AppColumnText(
//               name: name,
//               date: message,
//               subTextColor: context.colorScheme.onSurface.withOpacity(.9),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Message extends StatelessWidget {
//    const Message({
//     super.key,
//     this.message,
//     this.id = 0,
//
//   });
//
//   final String? message;
//   final int? id;
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: id == 0 ? Alignment.centerLeft : Alignment.centerRight,
//       child: Container(
//         padding:  const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
//         decoration: BoxDecoration(
//             color: id!.isOdd ? context.colorScheme.onSurface.withOpacity(.09) : context.colorScheme.secondary.withOpacity(.15),
//             borderRadius: id!.isOdd ?  const BorderRadius.only(
//               topLeft: Radius.circular(0),
//               topRight: Radius.circular(8),
//               bottomRight: Radius.circular(8),
//               bottomLeft: Radius.circular(8),
//             )
//                 :
//              const BorderRadius.only(
//               topLeft: Radius.circular(8),
//               topRight: Radius.circular(8),
//               bottomRight: Radius.circular(0),
//               bottomLeft: Radius.circular(8),
//             )
//         ),
//         child: Text(
//           message ?? '',
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 12.responsiveText,
//             color: context.colorScheme.onSurface,
//           ),
//         ),
//       ).paddingSymmetric(horizontal: 30),
//     );
//   }
// }
//
// class MissingWordDashBoard extends StatelessWidget {
//    const MissingWordDashBoard({
//     super.key,
//     this.name,
//     this.date,
//     this.submission,
//     this.onTap,
//   });
//   final String? name;
//   final String? date;
//   final String? submission;
//   final Function()? onTap;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         width: 289,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name ?? '',
//               style: TextStyle(
//                 fontSize: 17.responsiveText,
//                 fontWeight: FontWeight.w600,
//                 color: context.colorScheme.onSurface,
//               ),
//             ),
//             15.heightBox,
//             Row(
//               children: [
//                 Text(
//                   date ?? '',
//                   style: TextStyle(
//                       fontSize: 12.responsiveText,
//                       color: context.colorScheme.onSurface,
//                       fontWeight: FontWeight.w400
//                   ),
//                 ),
//                 10.widthBox,
//                 Text(
//                   '${submission ?? "0"} submissions',
//                   style: TextStyle(
//                       fontSize: 12.responsiveText,
//                       color: context.colorScheme.onSurface,
//                       fontWeight: FontWeight.w400
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Comment extends StatelessWidget {
//    const Comment({
//     super.key,
//     this.name,
//     this.date,
//     this.text,
//     this.img,
//   });
//
//   final String? name;
//   final String? date;
//   final String? img;
//   final String? text;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppAvatar(
//           width: width < 420 ? 40 : 53,
//           height: width < 420 ? 40 : 53,
//           imgUrl: img ?? '',
//         ),
//         5.widthBox,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppColumnText(
//                 name: name ?? '',
//                 textStyle: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                       fontSize: width < 420 ? 15 : 18,
//                       fontWeight: FontWeight.w600,
//                     )
//                 ),
//                 date: date,
//               ),
//               10.heightBox,
//               LongText(
//                 text: text ?? '',
//                 textStyle: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       fontSize: width < 420 ? 10 : 12,
//                       fontWeight: FontWeight.w400
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//
