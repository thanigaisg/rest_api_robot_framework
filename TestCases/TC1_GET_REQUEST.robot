*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    https://reqres.in
${page}        2

*** Test Cases ***
Get_Users
    Create Session    mysession     ${base_url}     verify=true
    ${resp}=    GET On Session   mysession     url=/api/users?page=${page}
    # Log To Console    ${resp.status_code}
    # Log To Console    ${resp.content}
    # Log To Console    ${resp.headers}

    # VALIDATIONS
    ${status_code}=     Convert To String  ${resp.status_code}
    Should Be Equal     ${status_code}   200

    ${body}=    Convert To String    ${resp.content}
    Should Contain    ${body}      reqres

    ${content_type_var}=    Get From Dictionary    ${resp.headers}   Content-Type
    Should Be Equal    ${content_type_var}      application/json; charset=utf-8