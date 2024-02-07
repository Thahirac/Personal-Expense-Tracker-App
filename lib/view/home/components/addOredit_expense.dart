import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import '../../../modal/expense_item.dart';


class AddOrEditExpense extends StatefulWidget {
  final ExpenseItem? expenseItem;
  AddOrEditExpense({Key? key, this.expenseItem});

  @override
  State<AddOrEditExpense> createState() => _AddOrEditExpenseState();
}

class _AddOrEditExpenseState extends State<AddOrEditExpense> {

  //Gloabal key for form validation
  final _formKey = GlobalKey<FormState>();

  // state class
  late  TextEditingController _titleController = TextEditingController();
  late TextEditingController _amountController = TextEditingController();
  late  TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectDate;
  String? currentItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.expenseItem?.name);
    _amountController = TextEditingController(text: widget.expenseItem?.amount);
    _descriptionController = TextEditingController(text: widget.expenseItem?.des);
    _selectDate =widget.expenseItem?.dateTime;
    currentItem = widget.expenseItem?.catogary;

  }

  void _submitData() {
    final isValid = _formKey.currentState?.validate();
    final expController = context.read<ExpenseProvider>();

    if(isValid!) {
      /// save
      ExpenseItem newExpense = ExpenseItem(
        name: _titleController.text,
        amount: _amountController.text,
        des: _descriptionController.text,
        dateTime: _selectDate!,
        catogary: currentItem!,
      );

      if(widget.expenseItem ==null) {
        ///add the new expense
        expController.addNewExpense(newExpense);
      }else{
        ///update expense
        expController.updateExpense(expController.overallExpenseList.indexOf(widget.expenseItem!),newExpense);
      }
      Navigator.of(context).pop(); // used to close the model sheet

    }
    else{
      print("not Valid");
    }
    expController.getSummary();
  }


  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then(
          (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        _selectDate = pickedDate;
        setState(() {

        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius
                        .vertical(
                        top: Radius.circular(20)),
                    color: Theme.of(context)
                        .primaryColor),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius
                                  .circular(2)),
                          alignment:
                          Alignment.center,
                        )),
                    Text(
                      widget.expenseItem==null? "Add New Expense" : "Update Expense",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.white,
                          fontSize:
                          Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.fontSize),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: TextFormField(
                          validator: (value){
                            if(_titleController.text.isEmpty){
                              return "* Expense name required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(labelText: 'Expense name',
                              border: OutlineInputBorder()),
                          controller: _titleController,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        validator: (value){
                          if(_amountController.text.isEmpty || double.parse(_amountController.text) <= 0 ){
                            return "* Amount required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Amount',
                            border: OutlineInputBorder()
                        ),
                        controller: _amountController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                child:
                TextFormField(
                  validator: (value){
                    if(_descriptionController.text.isEmpty){
                      return "* Description required";
                    }
                    return null;
                  },
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    validator: (value) {
                      if (currentItem == null || currentItem!.isEmpty) {
                        return '* Select an option';
                      }
                      return null;
                    },
                    isExpanded: true,
                    items: <String>[
                      'Food',
                      'Travel',
                      'Entertainment',
                      'Others',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: currentItem==null? const Text(" Select a type") : Text(currentItem.toString()),
                    style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.black),
                    onChanged: (String? value) {
                      setState(() {
                        currentItem = value;
                      });

                      print(currentItem);
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child:
                        _selectDate == null
                            ? Text('  * No date chosen!',style: TextStyle(color: Colors.red.shade900,fontSize: 12),)
                            : Text('  ${DateFormat.yMd().format(_selectDate!)}'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _presentDatePicker,
                        child: const Text('Choose date',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    /// submit button
                    if(_selectDate!=null) {
                      _submitData();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child:  Text(
                    widget.expenseItem ==null?'Add Expense':"Edit Expense",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
