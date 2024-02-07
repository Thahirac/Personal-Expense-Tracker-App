import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import '../helpers/show_custom_alert.dart';
import '../helpers/notificationservice.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Settings",style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context,data,child){
          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                child: ListTile(
                  textColor: Colors.purple,
                  trailing: Icon(Icons.notifications,color: Colors.deepPurple,),
                  onTap: ()async{
                    await ShowCustomAlert.showNotificationAlertDialog(context).then((value)async {
                      final box =await Hive.openBox('notificationTypeDb');
                      NotificationService.cancel();
                      box.put('notificationTypeDb', value);

                        NotificationService.showPeriodicNotification(
                            title: "Daily Expense Notification",
                            body: "Please record your daily expense",
                            payload: "This is Daily Expense Notification",notifcationType:value);

                    });
                  },
                  title: Text("Change Notfication Preference",style: TextStyle(color: Colors.black),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                child: ListTile(
                  textColor: Colors.purple,

                  trailing: Icon(Icons.logout,color: Colors.deepPurple,),
                  onTap: (){
                    ShowCustomAlert.showExitAlertDialog(context);
                  },
                  title: Text("Logout",style: TextStyle(color: Colors.black),),
                ),
              ),


            ],
          );
        },
      ),
    );
  }
}
