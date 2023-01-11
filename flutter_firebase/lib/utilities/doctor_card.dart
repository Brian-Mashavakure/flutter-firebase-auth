import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget{
  final imagePath;
  final String rating;
  final String doctorName;
  final String doctorProffession;

  DoctorCard({
    required this.imagePath,
    required this.rating,
    required this.doctorName,
    required this.doctorProffession,
  });

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Center(
        child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                       decoration: BoxDecoration(
                         color: Colors.deepPurple[100],
                         borderRadius: BorderRadius.circular(12),

                       ),
                        child: Column(
                          children: [
                            //Picture Of Doctor
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                imagePath,
                                height: 100,
                              ),
                            ),

                            SizedBox(height:10,),
                            //Doctor's Rating
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                    color: Colors.yellow[600]
                                ),
                                Text(rating,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)
                              ],
                            ),
                            SizedBox(height:25,),
                            //Doctor Name
                            Text(doctorName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),),

                            SizedBox(height: 10,),
                            //Doctor's Title
                            Text(doctorProffession + ' 7 years of experience')
                          ]

                        ),
                      ),
                    ),
      ),
    );



    
  }
}