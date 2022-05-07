part of 'edittask_cubit.dart';

@immutable
abstract class EditTaskState {
  final TaskEntity task;

  const EditTaskState(this.task);
}

class EditTaskInitial extends EditTaskState {
  const EditTaskInitial(TaskEntity task) : super(task);
}

class EditTaskPriorityChange extends EditTaskState {
  const EditTaskPriorityChange(TaskEntity task) : super(task);
}
