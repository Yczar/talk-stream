import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_stream/app/view/widgets/custom_text_field.dart';
import 'package:talk_stream/app/view/widgets/margins/x_margin.dart';
import 'package:talk_stream/app/view/widgets/margins/y_margin.dart';

import 'package:talk_stream/chat/cubits/chat_cubit.dart';
import 'package:talk_stream/chat/models/chat.dart';

class WebChatPage extends StatefulWidget {
  const WebChatPage({super.key});

  @override
  State<WebChatPage> createState() => _WebChatPageState();
}

class _WebChatPageState extends State<WebChatPage> {
  late TextEditingController _messageController;
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.read<UserProvider>().user;
    return _WebChatView(
      const [],
      _messageController,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class _WebChatView extends StatelessWidget {
  const _WebChatView(
    this.chats,
    this.messageController,
  );
  final List<Chat> chats;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: size.width / 2.5,
            child: Container(
              color: const Color(0xFFFFFDF9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent chats',
                          style: TextStyle(
                            color: Color(0xFF121212),
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            // await showDialog<dynamic>(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return ContactListAlertDialog(
                            //       contacts: contacts,
                            //       chats: chats,
                            //     );
                            //   },
                            // );
                          },
                          icon: const Icon(Icons.add_circle, size: 26),
                          label: const Text(
                            'New Message',
                          ),
                        )
                      ],
                    ),
                  ),
                  const YMargin(10),
                  Expanded(
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        // if (state is WebChatLoaded) {
                        // final chats = state.chats;
                        return ListView.separated(
                          cacheExtent: 1,
                          separatorBuilder: (_, __) => const YMargin(20),
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            final chat = chats[index];
                            final user = chat.user;
                            return InkWell(
                              onTap: () {
                                // final chat = chats.firstWhereOrNull(
                                //   (cht) =>
                                //       cht.members
                                //           ?.contains(user.userId) ??
                                //       false,
                                // );
                                // context
                                //     .read<WebChatRoomCubit>()
                                //     .updateCurrentRoom(
                                //       user,
                                //       chat,
                                //     );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                  20,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFF2F2F2),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      // backgroundImage: MemoryImage(
                                      //   Uint8List.fromList(
                                      //     user!.profilePicture.codeUnits,
                                      //   ),
                                      // ),
                                    ),
                                    const XMargin(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'name',
                                            style: TextStyle(
                                              color: Color(0xFF121212),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Chat.nessafe',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '2:58PM',
                                          style: TextStyle(
                                            color: const Color(0xFF1F1F1F)
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const YMargin(5),
                                        const CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 10,
                                          child: Center(
                                            child: Text(
                                              '2',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        // } else if (state is WebChatLoading) {
                        //   return const Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        // return const Offstage();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                // if (state is WebChatRoomLoading) {
                //   return const Center(child: CircularProgressIndicator());
                // } else if (state is WebChatRoomInitial) {
                //   return Center(
                //     child: Text(
                //       'Select a chat to view details',
                //       style: Theme.of(context)
                //           .textTheme
                //           .headlineSmall
                //           ?.copyWith(color: const Color(0xFF1A1A1A)),
                //     ),
                //   );
                // } else if (state is WebChatRoomUpdated) {
                //   final user = state.user;
                return Column(
                  children: [
                    const YMargin(5),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        // backgroundImage: MemoryImage(
                        //   Uint8List.fromList(
                        //     user.profilePicture.codeUnits,
                        //   ),
                        // ),
                      ),
                      title: Text(
                        'user.name',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 5,
                        cacheExtent: 1,
                        separatorBuilder: (_, __) => const YMargin(5),
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DecoratedBox(
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF1F1F1F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BottomAppBar(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: '',
                              hintText: 'Send a message',
                              controller: messageController,
                              icon: Icons.abc,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    )
                  ],
                );
                // }
                // return const Offstage();
              },
            ),
          ),
        ],
      ),
    );
  }
}



// class ContactListAlertDialog extends StatefulWidget {
//   const ContactListAlertDialog({
//     super.key,
//     required this.contacts,
//     required this.chats,
//   });
//   final List<Contact> contacts;
//   final List<WebChat> chats;

//   @override
//   _ContactListAlertDialogState createState() => _ContactListAlertDialogState();
// }

// class _ContactListAlertDialogState extends State<ContactListAlertDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return AlertDialog(
//       title: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'All Users',
//               style: TextStyle(
//                 color: Color(0xFF121212),
//                 fontSize: 24,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.close_outlined,
//               ),
//             ),
//           ],
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoaded) {
//               return ListBody(
//                 children: state.users.map((user) {
//                   return InkWell(
//                     onTap: () {
//                       final chat = widget.chats.firstWhereOrNull(
//                         (cht) => cht.members?.contains(user.userId) ?? false,
//                       );
//                       context.read<WebChatRoomCubit>().updateCurrentRoom(
//                             user,
//                             chat,
//                           );
//                       Navigator.of(context).pop();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(
//                         20,
//                       ),
//                       width: size.width * 0.8,
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 5,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: const Color(0xFFF2F2F2),
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.grey,
//                             backgroundImage: MemoryImage(
//                               Uint8List.fromList(user.profilePicture.codeUnits),
//                             ),
//                           ),
//                           const XMargin(10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   user.name,
//                                   style: const TextStyle(
//                                     color: Color(0xFF121212),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   user.email,
//                                   style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             } else if (state is HomeLoading) {
//               return const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(
//                   Color(0xFF1F1F1F),
//                 ),
//               );
//             }
//             return const Offstage();
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
