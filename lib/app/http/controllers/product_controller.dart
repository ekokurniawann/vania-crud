import 'package:belajar_api_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request request) async {
    request.validate({
      'name': 'required',
      'description': 'required',
      'price': 'required',
    }, {
      'name.required': 'nama tidak boleh kosong',
      'description.required': 'deskripsi tidak boleh kosong',
      'price.required': 'harga tidak boleh kosong',
    });

    final requestData = request.input();
    requestData['created_at'] = DateTime.now().toIso8601String();

    final existingProduct =
        await Product().query().where('name', '=', requestData['name']).first();
    if (existingProduct != null) {
      return Response.json(
        {
          "message": "produk sudah ada",
        },
        409,
      );
    }
    await Product().query().insert(requestData);

    return Response.json({
      "message": "product berhasil ditambahkan",
      "data": requestData,
    }, 201);
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show() async {
    final products = await Product().query().get();
    if (products.isEmpty) {
      return Response.json({
        "message": "daftar product",
        "data": [],
      }, 404);
    }
    return Response.json({
      "message": "daftar product",
      "data": products,
    }, 200);
  }

  Future<Response> update(Request request, int id) async {
    request.validate({
      'name': 'required',
      'description': 'required',
      'price': 'required',
    }, {
      'name.required': 'nama tidak boleh kosong',
      'description.required': 'deskripsi tidak boleh kosong',
      'price.required': 'harga tidak boleh kosong',
    });

    final requestData = request.input();
    requestData['updated_at'] = DateTime.now().toIso8601String();

    final affectedRows =
        await Product().query().where('id', '=', id).update(requestData);
    if (affectedRows == 0) {
      return Response.json({
        "message": "produk dengan id $id tidak di temukan",
      }, 404);
    }

    return Response.json({
      "message": "product berhasil di update",
      "data": requestData,
    }, 200);
  }

  Future<Response> destroy(int id) async {
    final affectedRows =
        await Product().query().where('id', '=', id).delete(id);
    if (affectedRows == 0) {
      return Response.json({
        "message": "produk dengan id $id tidak di temukan",
      }, 404);
    }

    return Response.json({
      "message": "product berhasil di hapus",
    }, 200);
  }
}

final ProductController productController = ProductController();
