*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://reqres.in

*** Test Cases ***
Put_CreateUser
    Create Session    mysession     ${base_url}     verify=True
    ${body}=    Create Dictionary    name=Rest_API  job=Robot_Framework
    Log To Console    ${body}
    ${header}=  Create Dictionary    Content-Type=application/json
    Log To Console    ${header}
    ${resp}=    POST On Session    mysession    /api/users  data=${body}    headers=${header}

    # VALIDATIONS
    ${status_code}=     Convert To String  ${resp.status_code}
    Should Be Equal     ${status_code}   201

