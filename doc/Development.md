# Development and Testing Guide <br> Roles Microservice

This document provides high-level instructions on how to build and test the microservice.

* [Environment Setup](#setup)
* [Installing](#install)
* [Testing](#test)

## <a name="setup"></a> Environment Setup

This is a Dart project, so you'll have to install Dart to work with it. 
You can download it from the official website: https://dart.dev/get-dart

You can check that Node.js has been successfully installed by running the following command:
```bash
dart --version
```

To work with the GitHub code repository you need to install Git from: https://git-scm.com/downloads

If you plan on developing and testing with persistent storages other than in-memory/flat file persistences,
you may need to install a database server:
- Download and install MongoDB from: https://www.mongodb.org/downloads

## <a name="install"></a> Installing

Once your environment is ready, you can check out the microservice's source code from the GitHub repository:
```bash
git clone https://github.com/pip-services-users/pip-services-roles-dart.git
```

Then go to the project folder and install dependent modules:

```bash
# Install dependencies
pub get
```

If you've worked with the microservice before, you can check out the latest changes and update the dependencies:
```bash
# Update source code updates from GitHub
git pull
```

## <a name="test"></a> Testing

The command to run unit tests is as follows:
```bash
pub run test ./test
```