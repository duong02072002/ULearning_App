import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/features/chat/controller/chat_ai_controller.dart';
import 'package:flutter_ulearning_app/common/models/chat_ai_entities.dart';

class ChatAIPage extends ConsumerStatefulWidget {
  const ChatAIPage({super.key});

  @override
  ConsumerState<ChatAIPage> createState() => _ChatAIPageState();
}

class _ChatAIPageState extends ConsumerState<ChatAIPage> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool showSidebar = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final notifier = ref.read(chatAIControllerProvider.notifier);
      await notifier.startNewSession();
      await notifier.loadSessionList();
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSend() {
    final message = _msgController.text.trim();
    if (message.isNotEmpty) {
      ref.read(chatAIControllerProvider.notifier).sendMessage(message);
      _msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatAIControllerProvider);

    // Trigger scroll mỗi lần messages thay đổi
    ref.listen<List<AIChatMessage>>(chatAIControllerProvider, (_, __) {
      _scrollToBottom();
    });

    final controller = ref.read(chatAIControllerProvider.notifier);
    final sessions = controller.sessionsList;
    final currentSession = controller.chatSession;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat AI"),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Show History',
            onPressed: () {
              setState(() {
                showSidebar = !showSidebar;
              });
            },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showSidebar)
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.4 > 260
                      ? 260
                      : MediaQuery.of(context).size.width * 0.4,
              color: Colors.grey[300],
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.startNewSession();
                      setState(() => showSidebar = false);
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: const Text(
                      "New Chat",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        final isSelected = session.session == currentSession;
                        return ListTile(
                          dense: true,
                          title: Text(
                            session.preview.isNotEmpty
                                ? session.preview
                                : 'Untitled',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                              color:
                                  isSelected ? Colors.blueAccent : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle:
                              session.createdAt != null
                                  ? Text(
                                    session.createdAt!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                  : null,
                          selected: isSelected,
                          selectedTileColor: Colors.white,
                          onTap: () {
                            controller.switchSession(session.session);
                            setState(() => showSidebar = false);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      messages.isEmpty
                          ? const Center(
                            child: Text(
                              "Let's start chatting with AI 🤖",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                          : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              final isUser = msg.role == "user";

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      isUser
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isUser)
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Color.fromARGB(
                                          255,
                                          21,
                                          97,
                                          229,
                                        ),
                                        child: Icon(
                                          Icons.smart_toy,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    if (!isUser) const SizedBox(width: 8),
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isUser
                                                  ? Colors.blue[200]
                                                  : Colors.grey[300],
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(16),
                                            topRight: const Radius.circular(16),
                                            bottomLeft: Radius.circular(
                                              isUser ? 16 : 4,
                                            ),
                                            bottomRight: Radius.circular(
                                              isUser ? 4 : 16,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          msg.content,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    if (isUser) const SizedBox(width: 8),
                                    if (isUser)
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.blueAccent,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                ),
                const Divider(height: 1),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (_) => _handleSend(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Material(
                        color: const Color.fromARGB(255, 52, 88, 249),
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _handleSend,
                          tooltip: 'Send message',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
