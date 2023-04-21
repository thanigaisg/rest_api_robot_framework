*** Settings ***
Library    os
Library    XML
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}    http://localhost:8080

*** Test Cases ***
TestCase:
    ${header}=  Create Dictionary    Accept=application/xml
    Create Session    mysession     ${base_url}     ${header}
    ${resp}=    GET On Session  mysession  /app/videogames

    ${xml_str}=   Convert To String    ${resp.content}
    ${xml_obj}=     Parse Xml    ${xml_str}

    # Check Single Element
    Element Text Should Be  ${xml_obj}   Tetris  .//videoGame[3].name

    # Check Attribute
    Element Attribute Should Be    ${xml_obj}   rating    Universal  .//videoGame[3]

    # Check the values of child elements
    ${child}=   Get Child Elements    ${xml_obj}    .//videoGame[2]
    Log To Console    ${child}
    Should Not Be Empty    ${child}

    ${id}=  Get Element Text    ${child[0]}
    ${name}=   Get Element Text     ${child[1]}
    ${score}=   Get Element Text    ${child[3]}

    Log To Console    ${id}
    Log To Console    ${name}
    Log To Console    ${score}

    Should Be Equal As Integers    ${id}    2
    Should Be Equal    ${name}  Gran Turismo 3
    Should Be Equal As Integers    ${score}     91