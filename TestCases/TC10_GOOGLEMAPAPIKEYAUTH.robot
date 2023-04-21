*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}=    https://maps.googleapis.com
${req_uri}=     /maps/api/place/nearbysearch/json?

*** Test Cases ***
GoogleMapAPIKeyAuth:
    Create Session    mysession     ${base_url}     verify=True
    ${params}=  Create Dictionary    location=-33.8670522,151.1957362   radius=500  types=restaurant    name=harbour    key=API_KEY
    ${resp}=    GET On Session    mysession     ${req_uri}  params=${params}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}