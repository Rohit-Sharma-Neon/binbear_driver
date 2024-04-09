import 'package:binbeardriver/ui/chat_tab/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChattingScreen extends StatefulWidget {
  final String? receiverId, receiverName, receiverProfilePic, schoolId, uniqueId;
  const ChattingScreen({super.key, this.receiverId, this.receiverName, this.receiverProfilePic, this.schoolId, this.uniqueId});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> with TickerProviderStateMixin{
  ChatController ctrl = Get.find<ChatController>();
  String userID = "";
  String currentMediaBaseURL = "";
  String currentBaseURL = "";
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // BaseOverlays().showLoader();
      // ctrl.messageList?.clear();
      // userID = await BaseSharedPreference().getString(SpKeys().userId)??"";
      // currentMediaBaseURL = await BaseSharedPreference().getString(SpKeys().currentMediaBaseURL)??ApiEndPoints().concatNullMediaUrl;
      // currentBaseURL = await BaseSharedPreference().getString(SpKeys().currentBaseURL)??"";
      ctrl.connectSocket(receiverId: (widget.receiverId??""),schoolId: (widget.schoolId??""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // body: Obx(()=>ListView.builder(
      //     controller: ctrl.scrollController,
      //     reverse: false,
      //     padding: const EdgeInsets.only(bottom: 3),
      //     itemCount: (ctrl.messageList?.length??0),
      //     itemBuilder: (context, index1) {
      //       return Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.only(top: 1.h,bottom: 1.h),
      //             child: Text(ctrl.formatDateToTodayOrYesterday(ctrl.messageList?[index1].date??""),style: TextStyle(
      //                 color: Colors.grey.shade600
      //             ),
      //            ),
      //           ),
      //           ListView.builder(
      //             shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             padding: EdgeInsets.all(15.sp),
      //             reverse: false,
      //             itemCount: ctrl.messageList?[index1].chatList?.length??0,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: EdgeInsets.only(bottom: index == (ctrl.messageList?[index1].chatList?.length??0) -1 ? 60.0 : 10.0),
      //                 child: Align(
      //                   alignment: (ctrl.messageList?[index1].chatList?[index].senderId?.sId??"") != userID ? Alignment.topLeft : Alignment.topRight,
      //                   child: Column(
      //                     crossAxisAlignment: (ctrl.messageList?[index1].chatList?[index].senderId?.sId??"") != userID ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           Container(
      //                             margin: EdgeInsets.only(right: (ctrl.messageList?[index1].chatList?[index].senderId?.sId??"") != userID ? 2.w : 0),
      //                             constraints: BoxConstraints(minWidth: 40.w, maxWidth: 80.w),
      //                             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //                             decoration: BoxDecoration(
      //                                 color: (ctrl.messageList?[index1].chatList?[index].senderId?.sId??"") != userID ? Colors.white : BaseColors.backgroundColor,
      //                                 borderRadius: BorderRadius.circular(5.0),
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                     color: BaseColors.darkShadowColor.withOpacity(0.5),
      //                                     blurRadius: 8.0,
      //                                   )
      //                                 ]
      //                             ),
      //                             child: Column(
      //                               mainAxisSize: MainAxisSize.min,
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               crossAxisAlignment: CrossAxisAlignment.center,
      //                               children: [
      //                                 Column(
      //                                   mainAxisSize: MainAxisSize.min,
      //                                   mainAxisAlignment: MainAxisAlignment.center,
      //                                   crossAxisAlignment: CrossAxisAlignment.center,
      //                                   children: [
      //                                     Visibility(
      //                                       visible: (ctrl.messageList?[index1].chatList?[index].type??"") == "media",
      //                                       child: GestureDetector(
      //                                         onTap: (){
      //                                           FocusScope.of(Get.context!).unfocus();
      //                                           BaseAPI().download(ctrl.messageList?[index1].chatList?[index].message??"");
      //                                         },
      //                                         child: const Icon(
      //                                           Icons.insert_drive_file_rounded,
      //                                           size: 100,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Visibility(
      //                                       visible: (ctrl.messageList?[index1].chatList?[index].type??"") == "video",
      //                                       child: GestureDetector(
      //                                         onTap: (){
      //                                           FocusScope.of(Get.context!).unfocus();
      //                                           Get.to(BaseVideoPlayer(videoUrl: ctrl.messageList?[index1].chatList?[index].message??""));
      //                                         },
      //                                         child: const Icon(
      //                                           Icons.play_circle,
      //                                           size: 60,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     Visibility(
      //                                       visible: (ctrl.messageList?[index1].chatList?[index].type??"") == "image",
      //                                       child: BaseImageNetwork(
      //                                         link: ctrl.messageList?[index1].chatList?[index].message??"",
      //                                         width: double.infinity,
      //                                         height: 170,
      //                                         borderRadius: 5,
      //                                       ),
      //                                     ),
      //                                     Visibility(
      //                                       visible: (ctrl.messageList?[index1].chatList?[index].type??"") == "text" || (ctrl.messageList?[index1].chatList?[index].type??"") == "media",
      //                                       child: Text(
      //                                         (ctrl.messageList?[index1].chatList?[index].message??"").toString().split("/").last,
      //                                         style: Style.montserratMediumStyle().copyWith(
      //                                           fontSize:16.sp,
      //                                           color: BaseColors.textBlackColor,
      //                                           fontWeight: FontWeight.w400,
      //                                         ),
      //                                         textAlign: TextAlign.start,
      //                                       ),
      //                                     ),
      //                                     Visibility(
      //                                       visible: (ctrl.messageList?[index1].chatList?[index].type??"") == "audio",
      //                                       child: VoiceMessage(
      //                                         audioSrc: (
      //                                             (ctrl.messageList?[index1].chatList?[index].message??"").contains("http"))
      //                                             ? (ctrl.messageList?[index1].chatList?[index].message??"")
      //                                             :  "$currentMediaBaseURL${ctrl.messageList?[index1].chatList?[index].message??""}",
      //                                         me: true,
      //                                         formatDuration: (Duration duration) {
      //                                           return duration.toString().substring(2, 7);
      //                                         },
      //                                         meBgColor: ctrl.messageList?[index1].chatList?[index].senderId?.sId == userID
      //                                             ? ColorConstants.primaryColorLight
      //                                             : Colors.white,
      //                                         meFgColor: ColorConstants.primaryColor,
      //                                         mePlayIconColor: ColorConstants.white,
      //                                         contactBgColor: ColorConstants.primaryColor,
      //                                         contactPlayIconBgColor: ColorConstants.primaryColor,
      //                                         played: false,
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(height: 0.8.h),
      //                       addText(getFormattedTime(ctrl.messageList?[index1].chatList?[index].createdAt??""), 14.sp, Colors.grey.shade600, FontWeight.w400),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      // bottomSheet: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       height: 10.h,
      //       color: Colors.white,
      //       padding: EdgeInsets.all(15.sp),
      //       child: Obx(()=>Row(
      //           children: [
      //             Expanded(
      //               child: CustomTextField(
      //                 controller: ctrl.msgCtrl,
      //                 focusNode: ctrl.focusNode,
      //                 hintText: ctrl.isRecording.value
      //                     ? 'Recording ${ctrl.recordingDuration.value.toString()}'
      //                     : "Message",
      //                 borderColor: Colors.transparent,
      //                 suffixIcon: Padding(
      //                   padding: const EdgeInsetsDirectional.only(end: 10),
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       GestureDetector(onTap: (){
      //                         BaseOverlays().showMediaPickerDialog(
      //                           onCameraClick: () async {
      //                             BaseOverlays().dismissOverlay();
      //                             ImagePicker picker = ImagePicker();
      //                             await picker.pickImage(source: ImageSource.camera).then((value){
      //                               if (value != null) {
      //                                 ctrl.selectedFile?.value = File(value.path);
      //                                 ctrl.getUploadedMediaUrlSingleChat(type: "image", receiverId: widget.receiverId??"");
      //                               }
      //                             },
      //                             );
      //                           },
      //                           onGalleryClick: () async {
      //                             BaseOverlays().dismissOverlay();
      //                             ImagePicker picker = ImagePicker();
      //                             await picker.pickImage(source: ImageSource.gallery).then((value) async {
      //                               if (value != null) {
      //                                 ctrl.selectedFile?.value = File(value.path);
      //                                 ctrl.getUploadedMediaUrlSingleChat(type: "image", receiverId: widget.receiverId??"");
      //                               }
      //                             });
      //                           },
      //                         );
      //                       },child: SvgPicture.asset("assets/images/gridicons_attachment.svg")),
      //                       SizedBox(
      //                         width: 2.w,
      //                       ),
      //                       GestureDetector(
      //                           onLongPress: ctrl.startRecording,
      //                           onLongPressEnd: (val){
      //                             ctrl.stopRecording(receiverId: widget.receiverId??"");
      //                           },
      //                           child: SvgPicture.asset("assets/images/Group 7724.svg")),
      //                     ],
      //                   ),
      //                 ),
      //                 fillColor: const Color(0xffF4F4F4),
      //                 borderRadius: 50,
      //                 hintTextColor: BaseColors.textLightGreyColor,
      //               ),
      //             ),
      //             SizedBox(width: 2.w),
      //             GestureDetector(
      //               onTap: (){
      //                 if (ctrl.msgCtrl.text.trim().isNotEmpty) {
      //                   ctrl.sendMessage(widget.receiverId, ctrl.msgCtrl.text.trim(), "text");
      //                   ctrl.update();
      //                   ctrl.msgCtrl.clear();
      //                   setState(() {});
      //                 }
      //               },
      //               child: Container(
      //                 padding: const EdgeInsets.all(8),
      //                 decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     color: BaseColors.backgroundColor,
      //                     border: Border.all(color: BaseColors.primaryColor)
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(left: 2.0),
      //                   child: SvgPicture.asset("assets/images/Layer 47.svg"),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    ctrl.socket?.disconnect();
    ctrl.socket?.dispose();
    ctrl.socket?.destroy();
    super.dispose();
  }
}
