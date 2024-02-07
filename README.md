# personal_expense_tracker_app

A Flutter App with which you can track and manage your weekly and total expenditures.
It shows a Real-Time Weekly and Total Pie Chart of the tracked Expenditures.
You can also delete and update an added expenditure.


## Details

• [Provider](https://pub.dev/packages/provider) for State Management

• [fl_Chart](https://pub.dev/packages/fl_chart) for Pie Chart

• [hive](https://pub.dev/packages/hive) for database operations

• [hive_Flutter](https://pub.dev/packages/hive_flutter) for database operations

### Screenshots

<img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/1ab079d3-cc1e-47a9-9db0-9475f720931b" alt="ss1" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/2c61f391-89c7-458d-8789-1b2887847acf" alt="ss2" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/180b32ab-3474-4974-b1a6-c8817fcb085b" alt="ss3" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/cb61c2f3-1bfe-4e43-a655-431e5cfaef75" alt="ss4" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/60c03276-8a53-44ae-b7d6-c0406ac8ad55" alt="ss5" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/0f9fd2a4-e7ee-46ab-a966-21c7d313d7ee" alt="ss6" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/d534411c-9cc1-488c-a8ea-4892b3a73883" alt="ss7" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/e6b867cb-a5d0-4591-bd7f-ffd40336c525" alt="ss8" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/a3f135bd-7aae-4371-beab-c4884e46a6af" alt="ss9" width="300" height="700"> <img src="https://github.com/Thahirac/Personal-Expense-Tracker-App/assets/84863922/ffe8545b-0711-42ea-8bfb-fae74da6fcc7" alt="ss10" width="300" height="700">

### Track your expenses. See Weekly and Total Pie Chart. Made with Flutter.

• Add Expense : Users can input the amount, date, and a brief description.

• View Expenses: Display expenses in a list, sorted and filterable by date.

• Edit/Delete Expense : Modify or remove expense entries.

• Expense Summary : Show summaries categorized by type, on a weekly or monthly basis.

• Reminder Notifications: Set up reminders for users to record their daily expenses.

## Running the Application

• Registering a New Account:

• Click on the "Register Now" Text.
• Fill in the registration form with your name, email, and password.
• Click on the "Sign-Up" button to create your account.

• Logging In:

• After registering, you can log in with your email and password on the login page.
• Click on the "Login" button after entering your credentials.

• Notification Preferences:

• Upon the first visit to the application, users will be prompted to choose their notification preferences.
• They can select from options like daily,hourly, or every minute.
• Once selected, the preference will be stored in the database for future use.
• And you can change your notification preferences at any time by navigating to the settings section.

• Adding an Expense:

• Click on the "Add Expense" button(FloatingActionButton).
• Fill in the details such as expense name, amount, category, description and date.
• Click on the "Add Expense" button to add the expense.

• Viewing Expenses:

• You can view your expenses, weekly and total summaries, represented on a pie chart, on the dashboard.
• Expenses can be filtered by date range for better analysis.
• And Expenses can be Sorted by date range or amount for better analysis.

• Editing an Expense:

• Click on the "Edit" button next to the expense you want to edit.
• Update the details as required.
• Click on the "Edit Expense" button to update the expense.

• Deleting an Expense:

• Click on the "Delete" button next to the expense you want to delete.
• Confirm the deletion when prompted.

•Logging Out:

• Click on the "Logout" button to log out of the application.
• Confirm the Logout when prompted.

### Personal Expense Tracker Application Report

• Introduction:

This report aims to provide insights into the design decisions, architectural choices, and testing approach implemented in the Personal Expense Tracker Application.

1. Design Decisions

-> User Interface (UI)

• Clean and Intuitive Design: The UI is designed to be user-friendly, with clear navigation and intuitive controls to ensure ease of use for users.
• Responsive Design: The application is built to be responsive, ensuring a consistent user experience across various devices and screen sizes.
• Minimalistic Approach: The UI follows a minimalist design approach, focusing on essential features and avoiding clutter to enhance usability.

-> Data Model

• Expense Model: The application utilizes a structured data model to store expense information, including fields such as name, amount, category,isLoggedIn and date.
• User Model: User authentication and authorization are implemented using a user model to manage user accounts securely.
• Notification Preferences: A separate model is used to store user notification preferences, allowing users to customize their notification settings.

2. Architectural Choices

-> Backend Architecture

Hive: Hive is chosen as the database system for its flexibility and scalability, allowing for easy storage and retrieval of structured data.
Model: Responsible for data handling and business logic.
View: Handles presentation logic and user interface components.
Controller: Manages communication between the model and view, handling user inputs and requests.(Used Provider State Managment)

4.Testing Approach

-> Unit Testing

• Unit Tests: Functions are tested using Flutter in build package 'flutter_test'.

5.Conclusion

The design decisions, architectural choices, and testing approach adopted in the Personal Expense Tracker Application aim to create a robust, scalable, and user-friendly platform for managing expenses effectively. By leveraging modern technologies and best practices, the application strives to deliver a seamless and intuitive user experience while maintaining code quality and reliability.

