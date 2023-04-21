*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}     https://reqres.in/


*** Test Cases ***
TestBasicAuth:
    ${auth_user}=   Create List    eve.holt@reqres.in   cityslicka
    Create Session    mysession     ${base_url}     auth=${auth_user}   verify=True
    ${data}=    Create Dictionary    email=eve.holt@reqres.in       password=cityslicka
    ${resp}=    POST On Session    mysession    /api/login  ${data}
    Should Be Equal As Integers    ${resp.status_code}      200
    Log To Console    ${resp.content}
