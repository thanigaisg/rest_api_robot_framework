*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://reqres.in

*** Test Cases ***
Put_CreateUser
    Create Session    mysession     ${base_url}     verify=True
    &{body}=  Create Dictionary  name=RestAPI  job=RobotFramework
    &{header}=  Create Dictionary  Content-Type=application/json  Connection=keep-alive
    ${resp}=  POST On Session   mysession  /api/users  json=${body}
    ...         headers=${header}
    Log To Console    ${resp.content}
    # VALIDATIONS
    ${status_code}=     Convert To String  ${resp.status_code}
    Should Be Equal     ${status_code}   201

