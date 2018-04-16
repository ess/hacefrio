**Registering A Device**
----
  Given the data for a device that is not yet registered, this endpoint registers the device on the API and provides it with a secret token for authenticated calls.

* **URL**

  /api/devices

* **Method:**
  
  `POST`

* **Authentication:**

  None
  
* **Data Params**

  The data for this request is expected to be encoded as valid JSON that contains a "device" root that contains a serial number and a firmware version.

  **Example**

  ```json
  {
    "device" : {
      "serial_number" : "d34db33f",
      "firmware" : "1.2.3"
    }
  }
  ```

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    
    ```json
    {
      "device" : {
        "secret" : "0s0sekrat",
        "created_at" : 1523891909
      }
    }
    ```
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:**
    
    ```json
    {
      "device" : {
        "errors" : [
          "You can only register once"
        ]
      }
    }
    ```

* **Sample Call:**

  ```
  curl -X POST -d '{"device":{"serial_number":"d34db33f","firmeware": "1.2"}}'
  ```
