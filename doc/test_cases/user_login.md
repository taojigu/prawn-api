
# Integration Test: API Chaining for Resource Management
## Objective
The objective of this integration test is to verify the dingding login interaction and data flow between three APIs in sequence:
1. ** Request Dingding Auth Code** : 
   input : 
   -"DingCorpID":"dingdfd635d844dc249df5bf40eda33b7ba0",
   - /sns_authorize

2. **Request Dingding token **: prawn/ding/token, if the user is new, insert a new user into prawn db
    input: Auth Code
   details:
   - request token :https://oapi.dingtalk.com/gettoken?appkey=%s&appsecret=%s
   - request get_user_info(union_id and user_id) with token and code:
     url https://oapi.dingtalk.com/topapi/v2/user/getuserinfo?access_token=%s",dingToken);
   - request user detail info with
      url : https://oapi.dingtalk.com/topapi/v2/user
      input: token and user_id  
   - save user detail in prawn db
   - generate prawn token with union_id
   - return prawn token
   expected:
   - prawn token is not empty
3. request prawn user info with prawn token
   input: prawn token
   steps:
   - request user info
   output: user info
---

## Test Case Details

### Preconditions
- **Environment Variables**:
    - `baseUrl`: Base URL of the APIs.
    - `authToken`: Authentication token (if required).

---

## APIs in Sequence

### API 1: Create Resource
- **Method**: `POST`
- **Endpoint**: `{{baseUrl}}/createResource`
- **Headers**:
    - `Content-Type`: `application/json`
    - `Authorization`: `Bearer {{authToken}}` (if required).
- **Request Body**:
  ```json
  {
    "name": "TestResource",
    "type": "example"
  }
  ```
- **Tests**:
    - Validate that the response status code is `201`.
    - Validate that the response contains a `resourceId`.
    - Save `resourceId` in the environment for subsequent API calls.

---

### API 2: Retrieve Resource
- **Method**: `GET`
- **Endpoint**: `{{baseUrl}}/getResource/{{resourceId}}`
- **Headers**:
    - `Authorization`: `Bearer {{authToken}}` (if required).
- **Tests**:
    - Validate that the response status code is `200`.
    - Validate that the response contains the following fields:
        - `name: TestResource`
        - `type: example`.

---

### API 3: Delete Resource
- **Method**: `DELETE`
- **Endpoint**: `{{baseUrl}}/deleteResource/{{resourceId}}`
- **Headers**:
    - `Authorization`: `Bearer {{authToken}}` (if required).
- **Tests**:
    - Validate that the response status code is `204`.
    - Validate that the resource no longer exists by attempting to retrieve it again (expect `404` or equivalent error).

---

## Execution Steps
1. Execute **API 1: Create Resource**.
    - Verify the `resourceId` is returned in the response.
    - Store `resourceId` in the environment.
2. Execute **API 2: Retrieve Resource** using the `resourceId`.
    - Verify that the retrieved resource details match the data submitted to API 1.
3. Execute **API 3: Delete Resource** using the `resourceId`.
    - Verify that the resource is successfully deleted by making another call to **API 2** and ensuring it returns an error.

---

## Expected Outcomes
1. Resource is successfully created, and a valid `resourceId` is returned.
2. Resource retrieval succeeds and matches the data submitted during creation.
3. Resource is successfully deleted, and subsequent retrieval attempts fail with a `404` or equivalent error.

---

## Post-Conditions
- **Environment Variable Cleanup**:
    - Ensure `resourceId` is unset after the test execution.
- **No Residual Data**:
    - Verify that no data related to the test is left on the server.

---

## Notes
- This test case assumes that APIs are sequentially dependent and require execution in the specified order.
- Ensure the test environment is isolated to avoid interference with other tests or data.
