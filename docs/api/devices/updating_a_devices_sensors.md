**Updating A Device's Sensors**
----
  Given a collection of timestampped sensor records, import all of the records
  into the API for analysis.

* **URL**

  /api/updates

* **Method:**
  
  `POST`

* **Authentication:**

  **Required:**

  Each Device has a unique serial number and is provided with a secret token
  upon registration. Authentication is performed by providing this pair
  (separated with ':') in the `Authorization` HTTP header for the request.

  **Example**

  `Authorization d34db33f:0s0sekrat`
  
* **Data Params**

  The data for this request is expected to be encoded as valid JSON that
  contains an "updates" root that contains a list of sensor update records.

  A single sensor update record is comprised of the following:
  
  * `at` (**required**): an Epoch UTC timestamp that reflects when the device
  recorded the sensor values
  * `temp` (optional): the current temperature according to the device
  * `humidity` (optional): the air humidity percentage according to the device
  * `co` (optional): the carbon monoxide concentration (in PPM) according to
  the device
  * `status` (optional): the overall health of the device

  This endpoint has no built-in error conditions, meaning that if you do
  receive a non-200 response, chances are fairly good that your payload is
  too large and you will need to retry, splitting the dataset into separate
  calls.

  **Example**

  ```json
  {
    "updates" : [
      {
        "at" : 12345660,
        "temp" : 34.6,
        "humidity": 15.1,
        "co" : 3.0,
        "status" : "Okay"
      },
      {
        "at" : 12345600,
        "temp" : 30.1,
        "humidity": 35.3,
        "co" : 2.0,
        "status" : "Error"
      },
      {
        "at" : 12345540,
        "temp" : 39.1,
        "humidity": 76.9,
        "co" : 5.0,
        "status" : "Okay"
      }
    ]
  }
  ```

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:**
    
    ```json
    {
      "update" : "success"
    }
    ```
 
* **Sample Call:**

  ```
  curl -X POST -d '{"updates":[{"at" : 12345660,"temp" : 34.6,"humidity": 15.1,"co" : 3.0,"status" : "Okay"}]}'
  ```
