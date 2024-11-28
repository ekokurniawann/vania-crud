import 'package:belajar_api_vania/app/http/controllers/product_controller.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.post('/create-product', productController.create);
    Router.get('/daftar-product', productController.show);
    Router.put('/edit-product/{id}', productController.update);
    Router.delete('/delete-product/{id}', productController.destroy);
  }
}
