*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${base_url}=    https://certtransaction.elementexpress.com/
${bearerToken}=     "Bearer E4F284BFADA11D01A52508ED7B92FFD7EE0905659F5DED06A4B73FC7739B48A287648801"

*** Test Cases ***
TestBearerToken:
    Create Session    mysession     ${base_url}     verify=True
    ${header}=  Create Dictionary    Authorization=${bearerToken}       Content-Type=text/xml
    ${req_body}=    Get File    xml_data.txt

    ${resp}=    POST On Session    mysession    /   data=${req_body}    headers=${header}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}
