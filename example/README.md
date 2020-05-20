# Examples for Roles Microservice

This is a user roles microservice from Pip.Services library. 
It provides basic role-based authorization mechanism for users. 

Define configuration parameters that match the configuration of the microservice's external API
```dart
// Service/Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the service
```dart
persistence = RolesMemoryPersistence();
persistence.configure(ConfigParams());

controller = RolesController();
controller.configure(ConfigParams());

service = RolesHttpServiceV1();
service.configure(httpConfig);

var references = References.fromTuples([
    Descriptor('pip-services-roles', 'persistence', 'memory',
        'default', '1.0'),
    persistence,
    Descriptor('pip-services-roles', 'controller', 'default',
        'default', '1.0'),
    controller,
    Descriptor(
        'pip-services-roles', 'service', 'http', 'default', '1.0'),
    service
]);

controller.setReferences(references);
service.setReferences(references);

await persistence.open(null);
await service.open(null);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = RolesHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
final ROLES = ['Role 1', 'Role 2', 'Role 3'];

    // Set the roles
    try {
      var role = await client.setRoles('123', '1', ROLES);
      // Do something with the returned roles...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the roles by id
try {
var role = await client.getRolesById(
    null,
    '1');
    // Do something with roles...

    } catch(err) { // Error handling}
```

```dart
// Grant user a role
try {
var role = await client.grantRoles(
    null,
    '1',
    ['admin']);
    // Do something with roles...

    } catch(err) { // Error handling}

// Authorize user
try {
var role = await client.authorize(
    null,
    '1',
    ['admin']);
    // Do something with bool value(authorized or not authorized) ...

    } catch(err) { // Error handling}    
```

In the help for each class there is a general example of its use. Also one of the quality sources
are the source code for the [**tests**](https://github.com/pip-services-users/pip-services-roles-dart/tree/master/test).
