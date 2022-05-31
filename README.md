# kitchen_anywhere

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Team Members

  - Milan Sheladiya (2092040)
  - Namra Patel (2093971)
  - Nency Patel (2093945)
  - Dishant Desai (2094440)

## Project Contribution

- ***Milan Sheladiya(Team Leader)***

          Signup:
            => User registration with firebase
            => After registration new user added to firebase
          Foodie:
            => DishDetail
		              UI
                  Users can change the quantity using a number picker
                  Add selected dish to cart with a selected quantity
                  Add favorite icon and functionality for dish 
                  Feedback and review UI

            => View Order
                  UI
                  Fetch all order lists for chef added dish 
                  Group based on orderId
         Chef:
            => View Order 
                  Fetch all order list for chef added dish
                  Group based on orderId

- ***Namra Patel***

         Login:
            => Login With Firebase/UI
            => Redirect user based on useType(Chef,Foodie)
            => If the chef user profile is pending or rejected prevent from login

        Foodie:
            => Home Screen 
                  UI
                  List of dishes 
            => Bottom Bar
                  UI(Profile/Home/Orders/Settings) 
                  Navigation respected screens
            => Cart 
                  UI
                  Change the quantity
                  Delete dishes from cart
            => Notification
        Chef:
            => List of Dishes 
                  UI
                  Fetch the list of dishes from firestore and display
                  Edit and delete dish swipe

- ***Nency Patel***

       Documentation:
            => Class Diagram
            => Activity Diagram
            => Sequence Diagram
            => Use Case Diagram
            => User Stories
       Splash Screen
       Login:
            => UI
            => validation
       Signup:
            => Validation
       Foodie:
            => Profile
                  UI
                  Update profile detail to firestore
       Chef:
            => Profile
                  UI
                  Update profile detail to firestore

       Common util functions of firebase for data manipulations

- ***Dishant Desai***

       Signup:
            => Signup UI
       Foodie:
            => Settings
                  UI(Logout)
		        => Cart
                  Add order to firebase
                  Order confirmation screen
            => Payment gateway integration

       Chef:
            => Add Dish 
                  UI 
                  Validation 
                  Upload Image to firebase 
                  Add all dish data to firestore
            => Edit Dish 
                  Update changed data to firestore


