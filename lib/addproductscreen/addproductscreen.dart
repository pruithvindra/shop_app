import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/home%20screen/homecreen.dart';
import 'package:shop_app/models/providers/products.dart';

class Addproductscreen extends StatefulWidget {
  static const routeName = 'addproduct';

  @override
  _AddproductscreenState createState() => _AddproductscreenState();
}

class _AddproductscreenState extends State<Addproductscreen> {
  var init = true;

  final _pricefocusnode = FocusNode();

  final _descriptionfocusnode = FocusNode();

  final _imageurlfocusnode = FocusNode();

  final imagecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _imageurlfocusnode.addListener(updateimage);
  }

  var editedproduct = Product(
    id: null,
    description: '',
    imageUrl: '',
    price: 0.0,
    title: '',
  );

  var initvalue = {'title': '', 'price': '', 'description': '', 'imageurl': ''};

  @override
  void didChangeDependencies() {
    if (init) {
      final prodid = ModalRoute.of(context).settings.arguments as String;

      if (prodid != null) {
        editedproduct = Provider.of<ProductsList>(context, listen: false)
            .prodlist
            .firstWhere((element) => element.id == prodid);
        initvalue = {
          'title': editedproduct.title,
          'price': editedproduct.price.toString(),
          'description': editedproduct.description,
          'imageurl': '',
        };

        imagecontroller.text = editedproduct.imageUrl;
      }
    }
    init = false;

    super.didChangeDependencies();
  }

  void updateimage() {
    if (!_imageurlfocusnode.hasFocus) {
      if ((!imagecontroller.text.startsWith('http') &&
              !imagecontroller.text.startsWith('https')) ||
          (!imagecontroller.text.endsWith('.png') &&
              !imagecontroller.text.endsWith('.jpg') &&
              !imagecontroller.text.endsWith('.jpeg'))) {}
      setState(() {});
    }
  }

  saveform() {
    formkey.currentState.save();

    if (editedproduct.id == null) {
      Provider.of<ProductsList>(context, listen: false)
          .addproduct(editedproduct);
    }
    Provider.of<ProductsList>(context, listen: false)
        .updateProduct(editedproduct.id, editedproduct);
  }

  @override
  void dispose() {
    _imageurlfocusnode.removeListener(updateimage);
    _pricefocusnode.dispose();
    _imageurlfocusnode.dispose();
    _descriptionfocusnode.dispose();
    imagecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                saveform();
                Navigator.of(context).popAndPushNamed('/');
              },
              child: Text('Save'))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
              key: formkey,
              child: Container(
                child: ListView(
                  children: [
                    FormField(
                      builder: (field) {
                        return TextFormField(
                          initialValue: initvalue['title'],
                          decoration: InputDecoration(
                            labelText: 'Enter tittle',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_pricefocusnode);
                          },
                          onSaved: (newValue) {
                            editedproduct = Product(
                              id: editedproduct.id,
                              isfavorite: editedproduct.isfavorite,
                              title: newValue,
                              description: editedproduct.description,
                              imageUrl: editedproduct.imageUrl,
                              price: editedproduct.price,
                            );
                          },
                        );
                      },
                    ),
                    FormField(
                      builder: (field) {
                        return TextFormField(
                          initialValue: initvalue['price'],
                          decoration: InputDecoration(
                            labelText: 'Enter price',
                          ),
                          focusNode: _pricefocusnode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionfocusnode);
                          },
                          onSaved: (newValue) {
                            editedproduct = Product(
                              id: editedproduct.id,
                              isfavorite: editedproduct.isfavorite,
                              title: editedproduct.title,
                              description: editedproduct.description,
                              imageUrl: editedproduct.imageUrl,
                              price: double.parse(newValue),
                            );
                          },
                        );
                      },
                    ),
                    FormField(
                      builder: (field) {
                        return TextFormField(
                          initialValue: initvalue['description'],
                          decoration:
                              InputDecoration(labelText: 'Enter description'),
                          textInputAction: TextInputAction.next,
                          focusNode: _descriptionfocusnode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_imageurlfocusnode);
                          },
                          onSaved: (newValue) {
                            editedproduct = Product(
                                id: editedproduct.id,
                                isfavorite: editedproduct.isfavorite,
                                title: editedproduct.title,
                                description: newValue,
                                imageUrl: editedproduct.imageUrl,
                                price: editedproduct.price);
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormField(
                            builder: (field) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Imagde URL',
                                ),
                                focusNode: _imageurlfocusnode,
                                controller: imagecontroller,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  saveform();
                                  Navigator.of(context).popAndPushNamed('/');
                                },
                                onSaved: (newValue) {
                                  editedproduct = Product(
                                      id: editedproduct.id,
                                      isfavorite: editedproduct.isfavorite,
                                      title: editedproduct.title,
                                      description: editedproduct.description,
                                      imageUrl: newValue,
                                      price: editedproduct.price);
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: width * 0.3,
                          height: height * 0.2,
                          child: imagecontroller.text.isEmpty
                              ? Text('enter url')
                              : Image.network(
                                  imagecontroller.text,
                                  fit: BoxFit.fill,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/providers/products.dart';

// class Addproductscreen extends StatefulWidget {
//   static const routeName = '/edit-product';

//   @override
//   AddproductscreenState createState() => AddproductscreenState();
// }

// class AddproductscreenState extends State<Addproductscreen> {
//   final _priceFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _editedProduct = Product(
//     id: null,
//     title: '',
//     price: 0,
//     description: '',
//     imageUrl: '',
//   );
//   var _initValues = {
//     'title': '',
//     'description': '',
//     'price': '',
//     'imageUrl': '',
//   };
//   var _isInit = true;
//   var _isLoading = false;

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(_updateImageUrl);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       final productId = ModalRoute.of(context).settings.arguments as String;
//       if (productId != null) {
//         _editedProduct = Provider.of<ProductsList>(context, listen: false)
//             .prodlist
//             .firstWhere((element) => element.id == productId);
//         _initValues = {
//           'title': _editedProduct.title,
//           'description': _editedProduct.description,
//           'price': _editedProduct.price.toString(),
//           // 'imageUrl': _editedProduct.imageUrl,
//           'imageUrl': '',
//         };
//         _imageUrlController.text = _editedProduct.imageUrl;
//       }
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _imageUrlFocusNode.removeListener(_updateImageUrl);
//     _priceFocusNode.dispose();
//     _descriptionFocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlFocusNode.hasFocus) {
//       if ((!_imageUrlController.text.startsWith('http') &&
//               !_imageUrlController.text.startsWith('https')) ||
//           (!_imageUrlController.text.endsWith('.png') &&
//               !_imageUrlController.text.endsWith('.jpg') &&
//               !_imageUrlController.text.endsWith('.jpeg'))) {
//         return;
//       }
//       setState(() {});
//     }
//   }

//   Future<void> _saveForm() async {
//     final isValid = _form.currentState.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });
//     if (_editedProduct.id != null) {
//       await Provider.of<ProductsList>(context, listen: false)
//           .updateProduct(_editedProduct.id, _editedProduct);
//     } else {
//       try {
//         await Provider.of<ProductsList>(context, listen: false)
//             .addproduct(_editedProduct);
//       } catch (error) {
//         await showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text('An error occurred!'),
//             content: Text('Something went wrong.'),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Okay'),
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//               )
//             ],
//           ),
//         );
//       }
//       // finally {
//       //   setState(() {
//       //     _isLoading = false;
//       //   });
//       //   Navigator.of(context).pop();
//       // }
//     }
//     setState(() {
//       _isLoading = false;
//     });
//     Navigator.of(context).pop();
//     // Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Product'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _form,
//                 child: ListView(
//                   children: <Widget>[
//                     TextFormField(
//                       initialValue: _initValues['title'],
//                       decoration: InputDecoration(labelText: 'Title'),
//                       textInputAction: TextInputAction.next,
//                       onFieldSubmitted: (_) {
//                         FocusScope.of(context).requestFocus(_priceFocusNode);
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please provide a value.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _editedProduct = Product(
//                           title: value,
//                           price: _editedProduct.price,
//                           description: _editedProduct.description,
//                           imageUrl: _editedProduct.imageUrl,
//                           id: _editedProduct.id,

//                           // isFavorite: _editedProduct.isFavorite
//                         );
//                       },
//                     ),
//                     TextFormField(
//                       initialValue: _initValues['price'],
//                       decoration: InputDecoration(labelText: 'Price'),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       focusNode: _priceFocusNode,
//                       onFieldSubmitted: (_) {
//                         FocusScope.of(context)
//                             .requestFocus(_descriptionFocusNode);
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please enter a price.';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Please enter a valid number.';
//                         }
//                         if (double.parse(value) <= 0) {
//                           return 'Please enter a number greater than zero.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _editedProduct = Product(
//                           title: _editedProduct.title,
//                           price: double.parse(value),
//                           description: _editedProduct.description,
//                           imageUrl: _editedProduct.imageUrl,
//                           id: _editedProduct.id,
//                         );
//                       },
//                     ),
//                     TextFormField(
//                       initialValue: _initValues['description'],
//                       decoration: InputDecoration(labelText: 'Description'),
//                       maxLines: 3,
//                       keyboardType: TextInputType.multiline,
//                       focusNode: _descriptionFocusNode,
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please enter a description.';
//                         }
//                         if (value.length < 10) {
//                           return 'Should be at least 10 characters long.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _editedProduct = Product(
//                           title: _editedProduct.title,
//                           price: _editedProduct.price,
//                           description: value,
//                           imageUrl: _editedProduct.imageUrl,
//                           id: _editedProduct.id,
//                         );
//                       },
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: <Widget>[
//                         Container(
//                           width: 100,
//                           height: 100,
//                           margin: EdgeInsets.only(
//                             top: 8,
//                             right: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           child: _imageUrlController.text.isEmpty
//                               ? Text('Enter a URL')
//                               : FittedBox(
//                                   child: Image.network(
//                                     _imageUrlController.text,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             decoration: InputDecoration(labelText: 'Image URL'),
//                             keyboardType: TextInputType.url,
//                             textInputAction: TextInputAction.done,
//                             controller: _imageUrlController,
//                             focusNode: _imageUrlFocusNode,
//                             onFieldSubmitted: (_) {
//                               _saveForm();
//                             },
//                             validator: (value) {
//                               if (value.isEmpty) {
//                                 return 'Please enter an image URL.';
//                               }
//                               if (!value.startsWith('http') &&
//                                   !value.startsWith('https')) {
//                                 return 'Please enter a valid URL.';
//                               }
//                               if (!value.endsWith('.png') &&
//                                   !value.endsWith('.jpg') &&
//                                   !value.endsWith('.jpeg')) {
//                                 return 'Please enter a valid image URL.';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _editedProduct = Product(
//                                 title: _editedProduct.title,
//                                 price: _editedProduct.price,
//                                 description: _editedProduct.description,
//                                 imageUrl: value,
//                                 id: _editedProduct.id,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
