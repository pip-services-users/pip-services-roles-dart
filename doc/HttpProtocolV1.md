# HTTP REST Protocol (version 1) <br/> Roles Microservice

Roles microservice implements a REST compatible API, that can be accessed on configured port.
All input and output data is serialized in JSON format. Errors are returned in [standard format]().

* [POST /roles/get_roles_by_id](#operation1)
* [POST /roles/set_roles](#operation2)
* [POST /roles/grant_roles](#operation3)
* [POST /roles/revoke_roles](#operation4)
* [POST /roles/authorize](#operation5)

## Operations

### <a name="operation1"></a> Method: 'POST', route '/roles/get_roles_by_id'

Gets all roles granted to specified user.

**Request body:** 
- user_id: string - unique user id

**Response body:**
- roles: [string] - all roles granted to the user
- or error

### <a name="operation2"></a> Method: 'POST', route '/roles/set_roles'

Sets all roles granted to specified user. 
This operation overrides all previously granted roles.

**Request body:**
- user_id: string - unique user id
- roles: [string] - all roles 

**Response body:**
- roles: [string] - all roles granted to the user
- or error

### <a name="operation3"></a> Method: 'POST', route '/roles/grant_roles'

Grant one or manu roles to the user. It doesn't affect other granted roles.

**Request body:**
- user_id: string - unique user id
- role: string - (optional) a role to be granted
- roles: [string] - (optional) a comma-separated list of roles to be granted

**Response body:**
- roles: [string] - all roles granted to the user
- or error

### <a name="operation4"></a> Method: 'POST', route '/roles/revoke_roles'

Revokes one or many roles from the user. It doesn't affect other granted roles.

**Request body:**
- user_id: string - unique user id
- role: string - (optional) a role to be revoked
- roles: [string] - (optional) a comma-separated list of roles to be revoked

**Response body:**
- roles: [string] - all roles granted to the user
- or error

### <a name="operation5"></a> Method: 'POST', route '/roles/authorize'

Authorizes user by checking if he was granted all requested roles.

**Request body:**
- user_id: string - unique user id
- roles: [string] - all roles granted to the user
- or error
