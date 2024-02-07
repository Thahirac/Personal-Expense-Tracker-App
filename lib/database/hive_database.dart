import 'package:hive/hive.dart';

import '../modal/expense_item.dart';
import '../modal/user.dart';

class HiveDataBase {
  /// Expense  box
  final _myBox1 = Hive.box("expense_database");

  /// User  box
  final _userBox = Hive.box('users');

  /// user registeer
  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required bool isLogged}) async {
    final user = User(email: email, pass: password, name: name, isLogged: isLogged);
    await _userBox.put("ALL_DATA", user);
  }

  /// user login
  Future<User?> login(
      {required String email,
      required String password,
      required String name,
      required bool isLogged}) async {
    final user =
        User(email: email, pass: password, name: name, isLogged: isLogged);
    await _userBox.putAt(0, user);
    final user1 = _userBox.get("ALL_DATA");
    if (user1 != null && user1.pass == password && user1.isLogged == true) {
      return user1;
    }
    return null;
  }

  /// user logout
  Future<void> logout(
      {required String email,
      required String password,
      required String name,
      required bool isLogged}) async {
    final user =
        User(email: email, pass: password, name: name, isLogged: isLogged);
    await _userBox.putAt(0, user);
  }


  /// write expense data
  void saveExpenseData(List<ExpenseItem> allExpense) {
    /*

   Hive can only store string and dateTime, and not custom objects like ExpenseItem
   So let's convert ExpenseItem objects into types that can be stored in our db

   allExpenses =
   [
   ExpenseItem ( name/ amount / dateTime )
   ..

   ]

   ->

   [

   [ name, amount, dateTime],
   ..

   ]

     */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      /// convert each expenseItem into a list of storable types (string, data)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.des,
        expense.dateTime,
        expense.catogary
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    /// finally let's store in our database
    _myBox1.put("ALL_EXPENSES", allExpensesFormatted);
  }

  /// read expense data
  List<ExpenseItem> readExpenseData() {
    /*


   Data is stored in Hive as a list String + dateTime
   So let's convert our saved data into ExpenseItem objects


   savedData =

     [

   [ name, amount, dateTime],
   ..

   ]

   ->


   [
   ExpenseItem ( name/ amount / dateTime )
   ..

   ]


    */

    List savedExpenses = _myBox1.get("ALL_EXPENSES") ?? [];

    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      ///collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      String des = savedExpenses[i][2];
      DateTime dateTime = savedExpenses[i][3];
      String category = savedExpenses[i][4];

      /// create expense item
      ExpenseItem expense = ExpenseItem(
          name: name,
          amount: amount,
          des: des,
          dateTime: dateTime,
          catogary: category);

      /// add expense to overall list of esxpenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(
      email: reader.readString(),
      pass: reader.readString(),
      name: reader.readString(),
      isLogged: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.email);
    writer.writeString(obj.pass);
    writer.writeString(obj.name);
    writer.writeBool(obj.isLogged);
  }
}
