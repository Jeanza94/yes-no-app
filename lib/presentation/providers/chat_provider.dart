
import 'package:flutter/widgets.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  
  final chatScrollController = ScrollController();
  
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [
    Message(text: 'hola bebe frutero', fromWho: FromWho.me),
    Message(text: 'Ya regreso de la frutería?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage( String text ) async {
    // todo: implementar metodo

    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);
    
    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();

    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messages.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }
}