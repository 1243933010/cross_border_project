import 'package:flutter/material.dart';


class SearchClass extends StatefulWidget{
  const SearchClass({super.key});
  _SearchClassState createState()=>_SearchClassState();
}

class _SearchClassState extends State<SearchClass>{
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        child: Container(
          width: 370,
          height: 40,
          color: Colors.white,
          child:Padding(
            padding: EdgeInsets.only(left: 10,),
            child: Row(
              children: [
                Icon(Icons.search,color: Colors.grey[700],),
                Text('ๆ็ดขๅๅ',style: TextStyle(color: Colors.grey[700],fontSize: 18),)
              ],
            ),
          ),
        ),
        onTap: ()=>{},
      ),
    );
  }
}