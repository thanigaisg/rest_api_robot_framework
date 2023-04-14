*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    http://localhost:8080


*** Test Cases ***
GET: Returns all the video games
    Create Session    mysession     ${base_url}
    ${resp}=    GET On Session    mysession     app/videogames
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}

    # Validations
    ${status_code}=     Convert To String   ${resp.status_code}
    Should Be Equal    ${status_code}   200

POST: Add a new video game
    Create Session    mysession     ${base_url}
    ${body}=    Create Dictionary    id=105     name=Captain-Marvel     releaseDate=2023-04-13T09:28:04.530Z    reviewScore=0   category=Marvel     rating=Good
    ${header}=  Create Dictionary    Content-Type=application/json
    ${resp}=    POST On Session    mysession    app/videogames  json=${body}    headers=${header}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}

    # Validations
    ${status_code}=     Convert To String    ${resp.status_code}
    Should Be Equal   ${status_code}    200

    ${content}=     Convert To String    ${resp.content}
    Should Contain    ${content}    Record Added Successfully

GET_ID: Return the specific video game details using the id
    Create Session    mysession     ${base_url}
    ${id}=  Convert To String    105
    ${resp}=    GET On Session    mysession     app/videogames/${id}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}

    # Validations
    ${status_code}=     Convert To String   ${resp.status_code}
    Should Be Equal    ${status_code}   200

    ${re_body}=     Convert To String    ${resp.content}
    Log To Console    ${re_body}
    Should Contain    ${re_body}    Captain-Marvel

PUT: Update the existing data
    Create Session    mysession     ${base_url}
    ${id}=  Convert To String    105
    ${body}=    Create Dictionary    id=105     name=Ant-Man     releaseDate=2023-04-13T09:28:04.530Z    reviewScore=0   category=Marvel     rating=Good
    ${header}=  Create Dictionary    Content-Type=application/json
    ${resp}=    PUT On Session    mysession    app/videogames/${id}  json=${body}    headers=${header}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}

    # Validations
    ${status_code}=     Convert To String   ${resp.status_code}
    Should Be Equal    ${status_code}   200

    ${re_body}=     Convert To String    ${resp.content}
    Should Contain  ${re_body}  Ant-Man

DELETE: Delete the existing entry
    Create Session    mysession     ${base_url}
    ${id}=  Convert To String    105
    ${resp}=    DELETE On Session    mysession     app/videogames/${id}
    Log To Console    ${resp.status_code}
    Log To Console    ${resp.content}

    # Validations
    ${status_code}=     Convert To String   ${resp.status_code}
    Should Be Equal    ${status_code}   200

    ${re_body}=     Convert To String    ${resp.content}
    Log To Console    ${re_body}
    Should Contain    ${re_body}    Record Deleted Successfully