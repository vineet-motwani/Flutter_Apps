import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:indus_valley_info_genai/bloc/chat_bloc.dart";
import "package:indus_valley_info_genai/models/chat_message_model.dart";
import "package:lottie/lottie.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/app_bg.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 120,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Indus Valley Info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            fontFamily: "Cinzel",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: messages[index].role == "user"
                                      ? Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.9)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.9),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      messages[index].role == "user"
                                          ? "You"
                                          : "Indus Valley Bot",
                                      style: messages[index].role == "user"
                                          ? const TextStyle(
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)
                                          : const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                    ),
                                    Text(
                                      messages[index].parts.first.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ));
                          })),
                  if (chatBloc.generating)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Lottie.asset(
                          "assets/loader.json",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Loading...",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: textEditingController,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              fillColor: Colors.white,
                              hintText: "Ask Something from AI",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                        )),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              chatBloc.add(ChatGenerateNewTextMessageEvent(
                                  inputMessage: text));
                            }
                          },
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Center(
                                child: Icon(Icons.send, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
