import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_list/data/data.dart';
import 'package:task_list/data/repo/repository.dart';

part 'edittask_state.dart';

class EdittaskCubit extends Cubit<EditTaskState> {
  final TaskEntity _task;
  final Repository<TaskEntity> repository;
  EdittaskCubit(this._task, this.repository) : super(EditTaskInitial(_task));

  void onSaveChangeClick() {
    repository.createOrUpdate(_task);
  }

  void onTextChange(String text) {
    _task.name = text;
  }

  void onPriorityChange(Priority priority) {
    _task.priority = priority;
    emit(EditTaskPriorityChange(_task));
  }
}
