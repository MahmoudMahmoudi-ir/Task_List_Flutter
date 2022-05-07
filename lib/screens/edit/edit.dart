import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/data/data.dart';
import 'package:task_list/main.dart';
import 'package:task_list/screens/edit/cubit/edittask_cubit.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: context.read<EdittaskCubit>().state.task.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        title: const Text('Edit Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<EdittaskCubit>().onSaveChangeClick();
            Navigator.of(context).pop();
          },
          label: Row(children: const [Text('Save Changes'), Icon(CupertinoIcons.check_mark, size: 18)])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<EdittaskCubit, EditTaskState>(
              builder: (context, state) {
                final priority = state.task.priority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () => context.read<EdittaskCubit>().onPriorityChange(Priority.high),
                          label: 'High',
                          color: primaryColor,
                          isSelected: priority == Priority.high,
                        )),
                    const SizedBox(width: 8),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () => context.read<EdittaskCubit>().onPriorityChange(Priority.normal),
                          label: 'Normal',
                          color: normalPriority,
                          isSelected: priority == Priority.normal,
                        )),
                    const SizedBox(width: 8),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () => context.read<EdittaskCubit>().onPriorityChange(Priority.low),
                          label: 'Low',
                          color: lowPriority,
                          isSelected: priority == Priority.low,
                        )),
                  ],
                );
              },
            ),
            TextField(
              controller: _controller,
              onChanged: (value) => context.read<EdittaskCubit>().onTextChange(value),
              decoration: InputDecoration(
                  label: Text(
                'Add a task for today...',
                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeFactor: 1.2),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final GestureTapCallback onTap;
  const PriorityCheckBox({
    Key? key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 2, color: secondaryTextColor.withOpacity(0.2)),
        ),
        child: Stack(
          children: [
            Center(child: Text(label)),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(child: _CheckBoxShape(value: isSelected, color: color)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBoxShape extends StatelessWidget {
  final bool value;
  final Color color;

  const _CheckBoxShape({Key? key, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
      child: value ? Icon(CupertinoIcons.check_mark, size: 12, color: themeData.colorScheme.onPrimary) : null,
    );
  }
}
