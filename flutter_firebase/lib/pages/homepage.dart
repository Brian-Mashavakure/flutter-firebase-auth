import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utilities/category_card.dart';
import '../utilities/doctor_card.dart';


class HomePage extends StatefulWidget{
  const HomePage({Key? key}): super(key : key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              //building app bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Name Area
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 18, ),),
                        SizedBox(height: 10,),
                        Text(
                          'Brian Mashavakure',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                              ,fontSize: 20),
                        )
                      ],
                    ),
                    //Profile Picture Area
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.person)),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              //How Do You Feel Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      //Note Taking Animation
                      Container(
                        height: 100,
                        width:  100,
                        child:Lottie.asset('animations/nurse-animation.json'),
                      ),
                      SizedBox(width: 20,),
                      //how do you feel area + get started button
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('How Do You Feel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text('Fill Out Your Medical Card',
                                style: TextStyle(
                                    fontSize: 15
                                )),
                            SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                color: Colors.deepPurple[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text('Get Started',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                              ),
                            )
                          ],

                        ),
                      )


                    ],
                  ),
                ),
              ),

              SizedBox(height: 25,),

              //Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'How Can We Help You?',
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25,),
              //Categories With Horizontal List View
              Container(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCard(
                          categoryName: 'Dentist',
                          iconImagePath: 'icons/tooth.png'
                      ),
                      CategoryCard(
                        categoryName: 'Surgery',
                        iconImagePath: 'icons/surgeon.png',
                      ),
                      CategoryCard(
                        categoryName: 'Phamarcy',
                        iconImagePath: 'icons/medicine.png',
                      ),
                    ],
                  )
              ),

              SizedBox(height: 25,),

              //Doctor List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Doctor List',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    Text('See All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ) ,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DoctorCard(
                      imagePath: 'images/doctor1.jpg',
                      rating: '4.9',
                      doctorName: 'Dr. Larry Pfachi',
                      doctorProffession: 'Therapist',
                    ),
                    DoctorCard(
                      imagePath: 'images/doctor2.jpg',
                      rating: '4.0',
                      doctorName: 'Dr. Panashe Musima',
                      doctorProffession: 'Chiropractor',
                    ),
                    DoctorCard(
                      imagePath: 'images/doctor3.jpg',
                      rating: '4.6',
                      doctorName: 'Dr. Allucard  Hellsing',
                      doctorProffession: 'Neuro-Surgeon',
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),

      ),

    );
  }
}