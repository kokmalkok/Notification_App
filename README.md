# Notification App
## 

## Current Application is analogy of Apple's application "Notification". Current application using only Xcode based frameworks and kits such as UIKit and CoreData. Main idea of application is make similar application like apple's "Notification" starting from UI and ended functionallities.

### ***Before using you need to unarchive Pods.zip in Notification Application Folder***

## **Main Objectives:**
1. Main Page. This page display table view and other tiles with user's notes and notifications. Table view consist of "Sort group" and have different categories which user choose by himself. Also this page has some edits function for edit cell, delete and adding new group categories. Separate tiles using for display different types categories of notification such as "Today","Tomorrow","All","Ended";
<img src="https://user-images.githubusercontent.com/70747233/212134247-c0fc8546-d4ba-4503-86ea-60ff38973c63.png" width="150">
2. Creating Group Page. This page display text field, selector for choosing color of text and image views and collection view for choosing image of future group;
<img src="https://user-images.githubusercontent.com/70747233/212134834-c74a6e05-5f14-4102-8d4d-3f84f538f8e9.png" width="150">
3. List Notifications Page. This page display table view with current notifications by current user's group. Potential for editing cells row, delete and remove;
<img src="https://user-images.githubusercontent.com/70747233/212134973-7aae0724-2c6c-4dca-aa16-7cb2fc940db5.png" width="150">
4. Create Notification Page. This page consist of text field for title of notification, note view for detail description and setting date and time for future notification if it necessary for user. After setups user choose in what exactly group need to add current notification;
<img src="https://user-images.githubusercontent.com/70747233/212135041-24126557-78ec-4c88-b533-47ce34ab1e84.png" width="150">
5. Add Reminder Page. This page include calendar and time selectors for setting up future user's notification, if it neccessary.
<img src="https://user-images.githubusercontent.com/70747233/212135298-8d714b7b-5f47-43e6-a8df-975cdc2b3786.png" width="150">



## **Personal Tasks in app:**
- Using UserNotifications;
- Using UIAlertControllers;
- Using TableView. Own customization of cells and table view at all;
- Using TableView Custom editing and deleting with data sources methods;
- Using Collection View. Own customization of cells for displaying and selecting colors and images for Group image and image color;
- Using ColorPicker View Controller. This new kit are alternative for selecting color of text and image in group;
- Using Protocol Delegates. This kit using for delegation data from second view to first one. Prefered to use delegation for less energy coast;
- Using Core Data. In this application planned to use two entities for dictionary synchronization, but in will be in next version of app. Groups of Notification app are stored in Core Data Entity and title of group used for dictionary key.



### **Future Improvements:**
* Add image to note field;
* Visual customization more look's like apple "Notification";
* Start to use CloudKit for transition data between several devices;
* Add UIMenu to alternative functionallity;
* Add function to add Notification from main page and potential save to exactly group;
* Use collection view instead of buttons on Main Page;
* Store all data in core data(or CloudKit);
* Full interaction between view controllers.
