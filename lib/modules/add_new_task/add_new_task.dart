import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskapp/modules/add_new_task/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:taskapp/modules/add_new_task/add_new_task_cubit/add_new_task_state.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({Key? key}) : super(key: key);

  var titleController = TextEditingController();
  var descController = TextEditingController();
  var empController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String _range = '';
  String startDate = '';
  String endDate = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewTaskCubit()..getUsersTask(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: BlocConsumer<AddNewTaskCubit, AddNewTaskState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: AddNewTaskCubit.get(context).allEmplyeesModel !=null,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add new task!',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        const Text(
                          'create a new task now and assign it!',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        const Text(
                          'to employees right way!',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        openDatePicker(context),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        TextFormField(
                          controller: titleController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'title',
                            label: Text('title'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'title must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        TextFormField(
                          controller: descController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Description',
                            label: Text('Description'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Description must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        TextFormField(
                          controller: empController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Assigned employee',
                            label: Text('Assigned employee'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Assigned employee must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        Text('Employees', style: TextStyle(color: Colors.black)),
                        ConditionalBuilder(
                          condition: AddNewTaskCubit.get(context).allEmplyeesModel!.data!.isNotEmpty,
                          builder: (context) => Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            child: DropdownButton(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              underline: const SizedBox(),
                              hint: const Text(
                                'Assigned Employees',
                                style: TextStyle(color: Colors.black),
                              ),
                              items: AddNewTaskCubit.get(context)
                                  .allEmplyeesModel!
                                  .data!
                                  .map((e) => DropdownMenuItem(
                                child: Text(e.name!),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (value) {
                                empController.text = value!.id.toString();
                              },

                            ),
                          ),
                          fallback: (context) =>CircularProgressIndicator(),
                        ),
                        ConditionalBuilder(
                          condition: state is !AddNewTaskLoadingState,
                          builder:(context) => Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xff5A55CA),
                                borderRadius: BorderRadius.circular(5)),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AddNewTaskCubit.get(context).createTask(
                                    name: titleController.text,
                                    description: descController.text,
                                    status: '0',
                                    startDate: startDate,
                                    endDate: endDate,
                                    employeeId: empController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'CREATE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => CircularProgressIndicator(),
            );
          }

        ),
      ),
    );
  }

  Widget openDatePicker(context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          // margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 60),
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              //border: Border.all(color: Colors.orangeAccent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: SfDateRangePicker(
              view: DateRangePickerView.month,
              monthViewSettings:
                  const DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
              selectionMode: DateRangePickerSelectionMode.range,
              showActionButtons: true,
              onSubmit: (val) {
                if (val is PickerDateRange) {
                  // AddNewTaskCubit.get(context).changeDate(
                  //     '${DateFormat('dd/MM/yyyy').format(val.startDate!)}',
                  //     ' ${DateFormat('dd/MM/yyyy').format(val.endDate ?? val.startDate!)}');
                  startDate = '${DateFormat('dd-MM-yyyy').format(val.startDate!)}' ;
                  endDate = ' ${DateFormat('dd-MM-yyyy').format(val.endDate ?? val.startDate!)}';
                  _range =
                      '${DateFormat('dd/MM/yyyy').format(val.startDate!)} -'
                      // ignore: lines_longer_than_80_chars
                      ' ${DateFormat('dd/MM/yyyy').format(val.endDate ?? val.startDate!)}';
                }
                print(startDate);
                print(endDate);
              },
              onCancel: () {})),
    ));
  }
}
