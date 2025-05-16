import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/widgets.dart';
import '../../questions.dart';

class QuestionAnswerSection extends StatelessWidget {
  const QuestionAnswerSection({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuestionState>();
    return (state.questionList.isNotEmpty)
        ? ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: state.questionList.length,
            itemBuilder: (BuildContext context, int index) {
              final question = state.questionList[index];
              return question.isActive
                  ? buildQuestionItem(state, question, index)
                  : const SizedBox.shrink();
            },
          )
        : const NoDataWidget();
  }

  Widget buildQuestionItem(
    QuestionState state,
    QuestionDataModel question,
    int index,
  ) {
    return ExpansionTile(
      title: Text(
        question.question,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: buildDynamicForm(state, question, index),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  child: InkWell(
                    onTap: () async {
                      await _onSubmit(state, question, index);
                    },
                    child: const Icon(Icons.check_box, size: 50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _onSubmit(
    QuestionState state,
    QuestionDataModel question,
    int index,
  ) async {
    final controller = state.answerController[index];

    if (controller != null) {
      await state.answerQuestion(
        questionCode: "${question.qcode}",
        answer: controller,
      );
    }
  }

  Widget buildDynamicForm(
    QuestionState state,
    QuestionDataModel question,
    int index,
  ) {
    if (question.type.toUpperCase() == "TEXT") {
      return TextFormField(
        maxLines: 6,
        onChanged: (value) {
          state.answerController[index] = value;
        },
        decoration: TextFormDecoration.decoration(hintText: ""),
      );
    } else {
      return Row(
        children: [
          buildRadioButton(state, label: "YES", index: index),
          buildRadioButton(state, label: "NO", index: index),
        ],
      );
    }
  }

  Widget buildRadioButton(
    QuestionState state, {
    required String label,
    required int index,
  }) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Row(
          children: <Widget>[
            Radio<String>(
              value: label,
              groupValue: state.answerController[index] ?? "",
              onChanged: (value) {
                setState(() {
                  state.answerController[index] = value!;
                });
              },
            ),
            Text(label),
          ],
        );
      },
    );
  }
}
