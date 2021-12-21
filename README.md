[![Dart Workflow](https://github.com/d-markey/pennyworth_builder/actions/workflows/dart.yml/badge.svg)](https://github.com/d-markey/pennyworth_builder/actions/workflows/dart.yml)
[![Null Safety](https://img.shields.io/badge/null-safety-brightgreen)](https://dart.dev/null-safety)
[![Dart Style](https://img.shields.io/badge/style-lints-40c4ff.svg)](https://pub.dev/packages/lints)
[![Last Commits](https://img.shields.io/github/last-commit/d-markey/pennyworth_builder?logo=git&logoColor=white)](https://github.com/d-markey/pennyworth_builder/commits)
[![Code Size](https://img.shields.io/github/languages/code-size/d-markey/pennyworth_builder?logo=github&logoColor=white)](https://github.com/d-markey/pennyworth_builder)
[![License](https://img.shields.io/github/license/d-markey/pennyworth_builder?logo=open-source-initiative&logoColor=green)](https://github.com/d-markey/pennyworth_builder/blob/master/LICENSE)
[![GitHub Repo Stars](https://img.shields.io/github/stars/d-markey/pennyworth_builder)](https://github.com/d-markey/pennyworth_builder/stargazers)

# Pennyworth Builder

OpenAPI code generator for Alfred, based on Pennyworth.

# Usage

1. Annotate your REST services and REST entities using Pennyworth annotations, e.g.:

```dart
@RestEntity(title: 'User info')
class UserInfoDto {
  UserInfoDto(this.userId, this.name, this.roles) : error = null;

  UserInfoDto.success(User user)
      : userId = user.userid,
        name = user.name,
        roles = user.roles.toList(),
        error = null;

  UserInfoDto.error(this.error)
      : userId = '',
        name = null,
        roles = null;

  final String userId;
  final String? name;
  final List<String>? roles;
  final RestError? error;

  Map toJson() => autoSerialize();
}
```

```dart
@RestService('/user', tags: ['USER'])
// ignore: camel_case_types
class User_v1 extends NestedOpenedApi {
  @RestOperation(uri: '/:userid:alpha', summary: 'Get user info')
  @RestOperation.middleware([ [RoleMiddleware, 'ADM'] ])
  Future<UserInfoDto> getUserInfo(String userId) async {
    final user = await _userService.getInfo(userId);
    if (user == null) {
      throw AlfredException(HttpStatus.notFound, 'User not found');
    }
    return UserInfoDto.success(user);
  }
}
```

2. In your server's main program, use Pennyworth's `OpenApiService` to register your REST services, and install the `SwaggerApi` to enable Swagger UI.

```dart
  final app = Alfred();

  app.typeHandlers.insert(0, openApiTypeHandler);

  final openApiService = setupOpenApiDocumentation_v3(app);

  var apis = [
    Api_v1(app.route('/api')),
    SwaggerApi(app.route('/dev/open-api'), openApiService, Directory('assets/swagger-ui-4.1.2/')),
  ];

  for (var api in apis) {
    openApiService.mount(api);
  }

  final server = await app.listen(8080);

  openApiService.addServer(server);
```

3. Create a Dart build file to generate Alfred services, including Open API documentation.

```yaml
targets:
  $default:
    builders: 
      pennyworth_builder:rest_builder: 
        generate_for: 
         - bin/**
        enabled: true 

builders:
  # name of the builder
  pennyworth_builder:rest_builder:
    # library URI containing the builder
    import: 'package:pennyworth_builder/pennyworth_builder.dart'
    # Name of the function in the above library to call.
    builder_factories: [ 'restServiceBuilder', 'restEntityBuilder' ]
    # The mapping from the source extension to the generated file extension
    build_extensions: { '.dart': [ '.svc.g.dart', '.dto.g.dart' ] }
    # Will automatically run on any package that depends on it
    auto_apply: dependents
    # Generate to a hidden cache dir
    build_to: cache
    # Combine the parts from each builder into one part file.
    applies_builders: ["source_gen|combining_builder"]
```

4. Build your project

```shell
dart run build_runner build
```

5. Run your app

```shell
dart run .\bin\server.dart
```

6. Point your browser to `http://localhost:8080/dev/open-api/index.html` and start exploring your APIs!

