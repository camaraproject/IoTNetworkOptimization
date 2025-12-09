# API Readiness Checklist

Checklist for kyc-match vwip

| Nr | API release assets  | alpha | release-candidate |  initial<br>public | stable<br> public | Status | Reference information |
|----|----------------------------------------------|:-----:|:-----------------:|:-------:|:------:|:----:|:----:|
|  1 | API definition                               |   M   |         M         |    M    |    M   |  Y   | [link](/code/API_definitions/iot-network-optimization.yaml) |
|  2 | Design guidelines from Commonalities applied |   O   |         M         |    M    |    M   |  N   |   not fully checked   |
|  3 | Guidelines from ICM applied                  |   O   |         M         |    M    |    M   |  N   |   not fully checked   |
|  4 | API versioning convention applied            |   M   |         M         |    M    |    M   |  Y   |   0.1.0-alpha.1   |
|  5 | API documentation                            |   M   |         M         |    M    |    M   |  Y   | Embedded documentation into API spec - [link](/code/API_definitions/iot-network-optimization.yaml) |
|  6 | User stories                                 |   O   |         O         |    O    |    M   |  Y   | [link](/documentation/API_documentation/IoT_Network_Optimization_UserStory_UseCase_1) |
|  7 | Basic API test cases & documentation         |   O   |         M         |    M    |    M   |  Y   | [link](/code/Test_definitions/iot-network-optimization-power-saving.feature) |
|  8 | Enhanced API test cases & documentation      |   O   |         O         |    O    |    M   |  N   |      |
|  9 | Test result statement                        |   O   |         O         |    O    |    M   |  N   |      |
| 10 | API release numbering convention applied     |   M   |         M         |    M    |    M   |  Y   |   r1.1   |
| 11 | Change log updated                           |   M   |         M         |    M    |    M   |  Y   |      |
| 12 | Previous public release was certified        |   O   |         O         |    O    |    M   |  N   |      |
| 13 | API description (for marketing)              |   O   |         O         |    M    |    M   |      | [wiki link](https://lf-camaraproject.atlassian.net/wiki/spaces/CAM/pages/129204225/IoTNetworkOptimization) |

To fill the checklist:
- in the line above the table, replace the api-name, api-version and the rx.y by their actual values for the current API version and release.
- in the Status column, put "Y" (yes) if the release asset is available or fulfilled in the current release, a "N" (no) or a "tbd". Example use of "tbd" is in case an alpha or release-candidate API version does not yet provide all mandatory assets for the release.
- in the Reference information column, provide the relative links (from the API repository home folder) to the release asset once available, the applicable release numbers (not versions) of Commonalities and ICM, and any other relevant links or information.
- For the point 12: The Reference information comment shall reference a note (e.g. "see (1)") under the checklist table to be added that states the certified company(s) as can be found on the following link: [GSMA Open Gateway Portal](https://open-gateway.gsma.com/).

Note: the checklists of a public API version and of its preceding release-candidate API version can be the same.

The documentation for the content of the checklist is here: see API Readiness Checklist section in the [API Release Process](https://lf-camaraproject.atlassian.net/wiki/x/jine).
