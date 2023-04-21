*** Settings ***
Library    JSONLibrary
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}    http://localhost:8080

*** Test Cases ***
ParseJSON: Returns all the video games
    Create Session    mysession     ${base_url}
    ${header}=      Create Dictionary    Accept=application/json
    ${resp}=    GET On Session    mysession     app/videogames      headers=${header}

    # Validations
    ${status_code}=     Convert To String   ${resp.status_code}
    Log To Console    ${status_code}
    Should Be Equal    ${status_code}   200

    # Single Data Validation
    ${category}=   Get Value From Json     ${resp.json()}   $[0].category
    Log To Console    ${category[0]}
    Should Be Equal    ${category[0]}      Shooter

    # Multiple Data Validations
    ${scores}=       Get Value From Json    ${resp.json()}   $[*].reviewScore
    ${scores_str}=      Convert To String    ${scores}
    Log To Console    ${scores_str}
    Should Contain Any    ${scores_str}     90  81  85  93  97
    Should Not Contain Any    ${scores_str}     20  11



