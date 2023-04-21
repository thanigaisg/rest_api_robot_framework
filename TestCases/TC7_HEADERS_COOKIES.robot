*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}     https://jsonplaceholder.typicode.com/

*** Test Cases ***
TestHeaders:
    Create Session    mysession     ${base_url}     verify=true
    ${resp}=    GET On Session    mysession     /photos
    Log To Console    ${resp.headers}

    ${content_type}=    Get From Dictionary    ${resp.headers}  Content-Type
    Should Be Equal    ${content_type}      application/json; charset=utf-8

    ${content_encoding}=    Get From Dictionary    ${resp.headers}  Content-Encoding
    Should Contain Any   ${content_encoding}      br    gzip

TestCookies:
    Create Session    mysession     ${base_url}     verify=true
    ${resp}=    GET On Session    mysession     /photos
    Log To Console    ${resp.cookies}