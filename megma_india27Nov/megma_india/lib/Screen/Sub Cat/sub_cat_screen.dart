import 'package:flutter/material.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getCatModel.dart';
import '../../Model/subcatModel.dart';
import '../../Widget/customAppbar.dart';
import '../product details/product_details_screen.dart';

class Sub_Category_Screen extends StatefulWidget {
  GetCatogryModel?getCatogryModel;
  int?indexx;
 Sub_Category_Screen({super.key,this.getCatogryModel,this.indexx});

  @override
  State<Sub_Category_Screen> createState() => _Sub_Category_ScreenState();
}

class _Sub_Category_ScreenState extends State<Sub_Category_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsubcat();
  }
  @override
  Widget build(BuildContext context) {
    return

      SafeArea(
        child: Scaffold(

        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child:

            CustomAppbar(
              textt: "${widget.getCatogryModel?.data[widget.indexx??0].title}",

            )),


        body:

         !isloading?
         subcatList.isEmpty? Container(height: MediaQuery.of(context).size.height,

           width: MediaQuery.of(context).size.width,

           child: Center(child:Text('Product Not Found',style: TextStyle(fontWeight: FontWeight.bold,),),),
         ):


         Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [

              Container(


                  height: 50,
                  decoration: BoxDecoration(

                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                      ),
                    ],


                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    // border: Border.all(color: Colors.black.withOpacity(0.3)
                    //
                    // )

                  ),
                  child: const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,color: AppColors.fieldColors,),
                      hintText: "Search",hintStyle: TextStyle(fontSize: 15,color: AppColors.fieldColors),
                      border: InputBorder.none,
                    ),
                  )),



              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Image.network(
                  '${widget.getCatogryModel?.data[widget.indexx??0].image}',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sub Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(0),
                  itemCount: subcatList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    return


                      InkWell(
                        onTap: () {

                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => product_Details_screen(
                                        productId: subcatList[index].id.toString(),
                                        ishomepage: true),
                                  ));
                        },
                        child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(10)),
                          height: 80,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage("${subcatList[index].image}"),
                                            fit: BoxFit.fill)),

                                  )),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "${subcatList[index].title}",
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                    ),
                      );
                  },
                ),
              ),
            ],
          ),
        )

                :


        Container(height: MediaQuery.of(context).size.height,

          width: MediaQuery.of(context).size.width,

          child: Center(child: LoadingWidget2(context),),
        )

        ),
      );
  }

bool isloading=false;
  GetSubCatModel?subCatModel;

  List<Sub_Category> subcatList=[];
  Future<void> getsubcat() async {


setState(() {
  isloading=true;
});
    var parameter={
"category_id":widget.getCatogryModel!.data[widget.indexx??0].id.toString(),
    };
    apiBaseHelper.postAPICall(
        getsubCatUrl,parameter
    ).then((getData){


      if (getData['status']) {
        setState(() {

          subCatModel= GetSubCatModel.fromJson(getData);



          for(int i=0;i<subCatModel!.data.length;i++){

            setState(() {
              subcatList.add(subCatModel!.data[i]);
            });


          }

          print("============${subcatList.length}");
          setState(() {
            isloading=false;
          });
        });

      }
      else {
        setState(() {
          isloading=false;
        });
      }


    },);


  }

}
