# Pizza Delivery - Backend with Dart

- A backend web server built using [Shelf](https://pub.dev/packages/shelf).
  <br>
  <img src="https://github.com/julianoventola/dw3_pizza_delivery_api/blob/master/backend.JPG">

# How to Start

- git clone
- open "pubspec.yaml" file and ru: pub get
- run: dart bin\server.dart

# Important

- Docker container used as mysql database\*
- Password hashed using SHA256
- No token used

# Routes

- User
  - Login: /user/auth
  - Register: /user/
- Menu
  - List Menu: /menu/
- Orders
  - Create Order: /order/
  - Find Order: /order/user/\<id\>
