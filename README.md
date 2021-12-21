# pennyworth_builder

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

2. Create a Dart build file to generate Alfred services, including Open API documentation.

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

3. Build your project

```shell
dart run build_runner build
```
