// ignore_for_file: constant_identifier_names

class AppName {
  static const String APP_NAME = "Woloo Task Management";
}

class MyLoginConstants {
  static const String WELCOME_TEXT = "Welcome to woloo \nsmart hygiene";
  static const String MOBILE_NO = "Enter your mobile number";
  static const String MOBILE_VALIDATION = "Please enter your mobile number";

  static const String SEND_OTP_BTN = "Send OTP";
  static const String VERIFY_OTP_BTN = "Verify & Proceed";

  static const String OTP_VERIFICATION = "OTP Verification";
  static const String ENTER_OTP =
      "Please enter the verification code below sent \n                on your +";
  static const String DIDNT_RECIEVED_OTP = "Didn’t receive OTP code?";
}

class MyFacilityListConstants {
  static const String POPUP_TEXT = "Do you want to start this task?";
  static const String POPUP_CANCEL_BUTTON = "Cancel";
  static const String POPUP_YES_BUTTON = "Yes";
}

class MyTaskListConstants {
  static const String APP_BAR = "Task";
  static const String POPUP_CANCEL_BUTTON = "Cancel";
  static const String POPUP_YES_BUTTON = "Yes";
  static const String SUBMIT_BTN = "Submit";
  static const String SKIP_BTN = "Skip";
  static const String POPUP_TITLE = "Do you want to Submit this task?";
  static const String HINT_TEXT = "Type here....";
  static const String SKIP_BTN_DIALOGUE = "Reason to skip";
}

class MySelfieScreenConstants {
  static const String TITLE_TEXT = "Take a selfie";
  static const String TITLE_SUBTEXT =
      "The image should be clear and have your face fully inside the frame";
  static const String SUBMIT_BTN = "Submit";
  static const String IMAGE_TYPE_SELFIE = "selfie";
}

class MydashboardScreenConstants {
  static const String TITLE_TEXT = "My Dashboard";
  static const String CLUSTER = "Cluster";
  static const String JANITOR = "Janitor";
  static const String FACILITY = "Facility";
  static const String LOG_OUT = "Log Out";

  static const String CUSTOMER_REQUEST = "Customer request";
  static const String REPORT_ISSUE = "Report Issue";
  static const String ALERT = "Alert";
  static const String ALERT_REQUEST = "New customer request ";
  static const String BUTTON = "View";
  static const String CHECK_IN = "Clock-In";
  static const String CHECK_OUT = "Clock-out";
  static const String CHECK_IN_TIME = "08:03:44  AM";
  static const String CHECK_OUT_TIME = "05:00:44  PM";
  static const String BLANK_LIST_TEXT =
      "Please Clock-In to see the list of task";
  static const String POPUP_TITLE = "Do you want to Check-Out?";
  static const String SUPERVISOR_TITLE_TEXT = "Hello,Shubham ";
}

class MyClusterListScreenConstants {
  static const String TITLE_TEXT = "Cluster";

  static const String BTN_TEXT = "Assign";
}

class MyFacilityScreenConstants {
  static const String TITLE_TEXT = "Tasks";

  static const String BTN_TEXT = "Reassign";
}

class MyJanitorsListScreenConstants {
  static const String TITLE_TEXT = "Janitors";

  static const String SUB_TITLE = "List of Janitors";
  static const String JANITOR_PRESENT = "Present";

  static const String JANITOR_ABSENT = "Absent";
}

class MyTaskDetailsScreenConstants {
  static const String APP_BAR = "Task details";
  static const String APPROVE_BUTTON = "Approve";

  static const String TITLE = "List of tasks";
}

class MyJanitorsDetailsScreenConstants {
  static const String APP_BAR = "Janitors Details";

  static const String SHIFT = "Shift";
  static const String GENDER = "Gender";
  static const String CHECK_IN = "Check In:";
  static const String CHECK_OUT = "Check Out:";
  static const String COMPLETE_TASK = "Complete Task:";
  static const String PENDING_TASK = "Pending task:";
  static const String TOTAL_TASK = "Total Task:";
}

class MyIssuesListScreenConstants {
  static const String TITLE_TEXT = "Issue list";

  static const String SUB_TITLE = "List of Janitors";
}

class MyReportIssueScreenConstants {
  static const String TITLE_TEXT = "Report Issue";
  static const String SUB_TITLE = "List of Janitors";

  static const String CLUSTER_NAME = "Cluster Name";
  static const String CLUSTER_NAME_VALIDATION = "Cluster Name is required";

  static const String FACILITY = "Facility";
  static const String FACILITY_VALIDATION = "Facility is required";

  static const String TASK_NAME = "Task name";
  static const String TASK_NAME_VALIDATION = "Task name is required";

  static const String DESCRIPTION = "Description";
  static const String DESCRIPTION_VALIDATION = "Description is required";

  static const String ASSIGN_TO = "Assign to";
  static const String ASSIGN_VALIDATION = "Assign to is required";

  static const String UPLOAD_PHOTO = "Upload Photo";
  static const String POP_UP_TEXT = "Your Issue submitted successfully";
}

class MyCustomerRequestListScreenConstants {
  static const String TITLE_TEXT = "Customer Request";

  static const String REQUEST_TYPE = "Classic cleaning";
  static const String REQUEST_STATUS = "Pending";
  static const String CUSTOMER_NAME = "Customer Name : ";
  static const String DATE_TIME = "22 Jun 2023, 12:00 PM-01:00 PM";
  static const String ADDRESS =
      "Flat no. 302, vedant apartment DP road Pimple nilakh ,";
  static const String PINCODE = "441256";
  static const String REJECT_BUTTON = "Reject";
  static const String ACCEPT_BUTTON = "Accept";
  static const String START_BUTTON = "Start";
  static const String DIRECTION_BUTTON = "Direction";
  static const String CLOSURE_BUTTON = "Request for closure";
  static const String FITER = "Filters";
}

class TaskCompletionScreenConstants {
  static const String TITLE_TEXT = "Add Photos of loo";
  static const String TITLE_SUBTEXT =
      "Please capture an image of the area you have been working on to validate it.";
  static const String END_TASK_BTN = "End Task";
  static const String REMARKS = "Remarks";
  static const String IMAGE_TYPE_TASK = "task";
}

class BottomNavigatiionBarConstants {
  static const String CLUSTER = "Cluster";
  static const String JANITORS = "Janitors";
  static const String REPORT_ISSUE = "Report issue";
  static const String ACCOUNT = "Account";
}
