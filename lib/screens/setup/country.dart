
import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import '../setup/attended.dart';


class Country extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights=MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
          //leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: ()=> Navigator.pop(context)),
          backgroundColor: Colors.white,
          elevation: 3,
          centerTitle: true,
          title: Text("Setup",style: TextStyle(color: Colors.black),),
          actions: [
            GestureDetector(
             // onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>Signin())),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text("Search",style: TextStyle(color: Color(0xff4667EE)),),

                  ],
                ),
              ),
            ),
          ]),
      body: Center(
        child: CountryListPick(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Choisir un pays'),
          ),
          // if you need custome picker use this
          pickerBuilder: (context, CountryCode countryCode){
            return Column(
              children: [
                SizedBox(height: heights.size.height*0.03,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: heights.size.width*0.30,
                        height: heights.size.height*0.01,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: heights.size.width*0.30,
                        height: heights.size.height*0.01,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: heights.size.width*0.30,
                        height: heights.size.height*0.01,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Colors.grey,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: heights.size.height*0.05,),
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Center(
                      child: Icon(Icons.location_on,color: Colors.black,size: 30,),
                    ),
                  ),
                  title:Text("Enter your origin Country"),

                ),
                // Row(
                //   children: [
                //     CircleAvatar(
                //       backgroundColor: Colors.deepOrangeAccent,
                //       child: Center(
                //         child: Icon(Icons.location_on,color: Colors.black,),
                //       ),
                //     ),
                //     Si
                //     Text("Enter your origin Country"),
                //   ],
                // ),
                SizedBox(height: heights.size.height*0.05,),
                DropdownButton(
                  onChanged: (val){},
                    items: [
                      DropdownMenuItem<DropdownMenuItem>(
                        child: CountryListPick(
                          appBar: AppBar(
                            backgroundColor: Colors.blue,
                            title: Text('Select your country'),
                          ),

                          // if you need custome picker use this
                          pickerBuilder: (context, CountryCode countryCode){
                            return Row(
                              children: [
                                Container(
                                  width:100,
                                  height: 50,
                                  child: Image.asset(
                                    countryCode.flagUri,
                                    package: 'country_list_pick',
                                  ),
                                ),
                                //Text(countryCode.code),
                                //Text(countryCode.dialCode),
                              ],
                            );
                          },
                          // To disable option set to false
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: true,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,
                          ),
                          // Set default value
                          initialSelection: '+91',
                          onChanged: (CountryCode code) {
                            print(code.name);
                            print(code.code);
                            print(code.dialCode);
                            print(code.flagUri);
                          },
                        ),
                      )
                    ]
                  ,
                ),
                SizedBox(height: heights.size.height*0.05,),
               LayoutBuilder(
                 builder: (ctx,con){
                   return  InkWell(
                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>Attended()),) ,
                     child: Padding(
                       padding: const EdgeInsets.all(30.0),
                       child: Center(
                         child: Container(
                           width:heights.size.width*1 ,
                           height: heights.size.height*0.05,
                           decoration: BoxDecoration(
                             color: Color(0xff4667EE),
                             borderRadius: BorderRadius.circular(5),
                           ),
                           child: Center(
                               child: Text("Next",
                                 style: TextStyle(
                                     color: Colors.white,fontSize: 18
                                 ),
                               )
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ),
              ],
            );
          },
        ),
      ),
    );
  }
}

