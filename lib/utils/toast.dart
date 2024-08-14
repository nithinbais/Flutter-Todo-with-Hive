import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todohive/main.dart';
import 'package:todohive/utils/strings.dart';

// Empty title or substring TextFiled warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: MyString.oopsMsg,
      subMsg: 'You Must fill all Fields',
      corner: 15.0,
      duration: 2000,
      padding: const EdgeInsets.all(10.0));
}

// Nothing entered when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: MyString.oopsMsg,
      subMsg: 'You Must edit the taks then try to update it !.',
      corner: 15.0,
      duration: 3000,
      padding: const EdgeInsets.all(10.0));
}

// No Task Warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: MyString.oopsMsg,
    message:
        'There is no Task for delete! /n Try adding some and then try to delete it!',
    buttonText: 'Okay',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// Delete All Task From DB Dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      title: MyString.areYouSure,
      message:
          'Do you really want to delete all task? you will be able to undo this action!',
      confirmButtonText: 'Yse',
      cancelButtonText: 'No', onTapConfirm: () {
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning, barrierDismissible: false);
}
