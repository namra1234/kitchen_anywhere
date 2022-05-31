import 'dart:math';

import '../common/constants.dart';
import '../model/OrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/dishModel.dart';

class OrderRepository {
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Order');

  dynamic createOrder(Map<String, dynamic> OrderModel) async {
    try{
      final newDocRef = collection.doc();
      await newDocRef.set(OrderModel);
      return true;
    }
    catch(e){
      print(e);
      return false;
    }

  }
  dynamic updateDish(Map<String, Object?> OrderModel,String? docId) async{
    try{
      final newDocRef = collection.doc(docId);
      // Map DishMap = Dishmodel.toJson();
      await newDocRef.update(OrderModel);
      return true;
    }
    catch(e){
      return false;
    }
  }
  dynamic deleteDish(String? docId) async{
    try{
      final newDocRef = collection.doc(docId);
      // Map DishMap = OrderModel.toJson();
      await newDocRef.delete();
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<List<OrderModel>> getAllOrder() async {
    List<OrderModel> orderList=[];

    final docSnapshot = await collection.get().then((var snapshot) async {
      final newDocRef = collection.doc();

      for(int i=0;i<snapshot.docs.length;i++)
      {

        Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
        List<DishModel> dishList1=[];
        for(int j=0;j<data!['dishList'].length;j++)
        {

          Map<String, dynamic>? d=data!['dishList'][j] as Map<String, dynamic>?;
          String? id = snapshot.docs[i].id;
          String? dishTitle = d!["dishTitle"].toString();
          String dishImageLink = d['dishImageLink'].toString();
          String typeOfDish = d['typeOfDish'].toString();
          String description = d['description'].toString();
          String postal_code = d['postal_code'].toString();
          double price = double.parse(d['price'].toString());
          int maxLimit = d['maxLimit'].toInt();
          int categoryId = d['categoryId'].toInt();
          int pending_limit = d['pending_limit'].toInt();
          bool isVegetarian  = d['isVegetarian'];
          bool isActive  = d['isActive'];
          int qty = d['qty'];

          Random random = Random();
          int _randomNumber1 = random.nextInt(5);

          Map? DishMap =  DishModel(id,dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
              isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,qty,postal_code
          ).toJson();
          dishList1.add(DishModel.fromMap(DishMap as Map<String,dynamic>));

        }

        String chefId = data!["chefId"].toString();
        String contactOfFoodie = data['contactOfFoodie'].toString();
        // List<DishModel> dishList = dishList1;
        String nameOfFoodie = data['nameOfFoodie'].toString();
        DateTime orderDate = data['orderDate'].toDate();
        String orderId = data['orderId'].toString();
        String orderStatus = data['orderStatus'].toString();
        String userId = data['userId'].toString();


        Random random = Random();
        int _randomNumber1 = random.nextInt(5);

        Map? OrderMap =  OrderModel(chefId,contactOfFoodie,dishList1,nameOfFoodie,orderDate,orderId,orderStatus,userId).toJson();
        orderList.add(OrderModel.fromMap(OrderMap as Map<String,dynamic>));
      }


    });

    return orderList;
  }

  Future<List<OrderModel>> getChefAllDish(String chef_id) async {
    List<OrderModel> orderList=[];
    final docSnapshot = await collection.where("chefId", isEqualTo: chef_id)
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();



      for(int i=0;i<snapshot.docs.length;i++)
      {

        Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
        List<DishModel> dishList1=[];
        for(int j=0;j<data!['dishList'].length;j++)
        {

          Map<String, dynamic>? d=data!['dishList'][j] as Map<String, dynamic>?;
          String? id = snapshot.docs[i].id;
          String? dishTitle = d!["dishTitle"].toString();
          String dishImageLink = d['dishImageLink'].toString();
          String typeOfDish = d['typeOfDish'].toString();
          String description = d['description'].toString();
          String postal_code = d['postal_code'].toString();
          double price = double.parse(d['price'].toString());
          int maxLimit = d['maxLimit'].toInt();
          int categoryId = d['categoryId'].toInt();
          int pending_limit = d['pending_limit'].toInt();
          bool isVegetarian  = d['isVegetarian'];
          bool isActive  = d['isActive'];
          int qty = d['qty'];

          Random random = Random();
          int _randomNumber1 = random.nextInt(5);

          Map? DishMap =  DishModel(id,dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
              isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,qty,postal_code
          ).toJson();
          dishList1.add(DishModel.fromMap(DishMap as Map<String,dynamic>));

        }

        String chefId = data!["chefId"].toString();
        String contactOfFoodie = data['contactOfFoodie'].toString();
        // List<DishModel> dishList = dishList1;
        String nameOfFoodie = data['nameOfFoodie'].toString();
        DateTime orderDate = data['orderDate'].toDate();
        String orderId = data['orderId'].toString();
        String orderStatus = data['orderStatus'].toString();
        String userId = data['userId'].toString();


        Random random = Random();
        int _randomNumber1 = random.nextInt(5);

        Map? OrderMap =  OrderModel(chefId,contactOfFoodie,dishList1,nameOfFoodie,orderDate,orderId,orderStatus,userId).toJson();
        orderList.add(OrderModel.fromMap(OrderMap as Map<String,dynamic>));
      }

      orderList.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    });



    return orderList;
  }


  Future<List<OrderModel>> getFoodieAllDish(String foodie_id) async {
    List<OrderModel> orderList=[];
    final docSnapshot = await collection.where("userId", isEqualTo: foodie_id)
        .get()
        .then((var snapshot) async {
      final newDocRef = collection.doc();



      for(int i=0;i<snapshot.docs.length;i++)
      {

        Map<String, dynamic>? data=snapshot.docs[i].data() as Map<String, dynamic>?;
        List<DishModel> dishList1=[];
        for(int j=0;j<data!['dishList'].length;j++)
        {

          Map<String, dynamic>? d=data!['dishList'][j] as Map<String, dynamic>?;
          String? id = snapshot.docs[i].id;
          String? dishTitle = d!["dishTitle"].toString();
          String dishImageLink = d['dishImageLink'].toString();
          String typeOfDish = d['typeOfDish'].toString();
          String description = d['description'].toString();
          String postal_code = d['postal_code'].toString();
          double price = double.parse(d['price'].toString());
          int maxLimit = d['maxLimit'].toInt();
          int categoryId = d['categoryId'].toInt();
          int pending_limit = d['pending_limit'].toInt();
          bool isVegetarian  = d['isVegetarian'];
          bool isActive  = d['isActive'];
          int qty = d['qty'];

          Random random = Random();
          int _randomNumber1 = random.nextInt(5);

          Map? DishMap =  DishModel(id,dishTitle,dishImageLink,typeOfDish,description,price,maxLimit,pending_limit,
              isVegetarian,isActive,Constants.loggedInUserID,categoryId, [] ,_randomNumber1,qty,postal_code
          ).toJson();
          dishList1.add(DishModel.fromMap(DishMap as Map<String,dynamic>));

        }

        String chefId = data!["chefId"].toString();
        String contactOfFoodie = data['contactOfFoodie'].toString();
        // List<DishModel> dishList = dishList1;
        String nameOfFoodie = data['nameOfFoodie'].toString();
        DateTime orderDate = data['orderDate'].toDate();
        String orderId = data['orderId'].toString();
        String orderStatus = data['orderStatus'].toString();
        String userId = data['userId'].toString();


        Random random = Random();
        int _randomNumber1 = random.nextInt(5);

        Map? OrderMap =  OrderModel(chefId,contactOfFoodie,dishList1,nameOfFoodie,orderDate,orderId,orderStatus,userId).toJson();
        orderList.add(OrderModel.fromMap(OrderMap as Map<String,dynamic>));
      }

      orderList.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    });

    return orderList;
  }

}