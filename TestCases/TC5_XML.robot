*** Settings ***
Library    XML
Library    os
Library    Collections


*** Test Cases ***
TestCase1:
    ${xml_obj}=     Parse Xml    video_games.xml

    # Validations
    # Val1 - Check the Single Element Value
    # Approach 1
    ${name}=    Get Element Text    ${xml_obj}      .//videoGame[2].name
    Log To Console    ${name}
    Should Be Equal    ${name}      Gran Turismo 3

    # Approach 2
    ${name}=    Get Element    ${xml_obj}      .//videoGame[1].name
    Log To Console    ${name.text}
    Should Be Equal    ${name.text}     Resident Evil 4

    # Approach 3
    Element Text Should Be    ${xml_obj}    Tetris      .//videoGame[3].name

    # Val2 - Check number of elements
    ${count}=   Get Element Count    ${xml_obj}      .//videoGame
    Should Be Equal As Integers   ${count}     10

    # Val3 - Check Attribute Presence
    Element Attribute Should Be    ${xml_obj}   category    Puzzle  .//videoGame[3]

    # Val4 - Check the values of child elements
    ${child}=   Get Child Elements    ${xml_obj}    .//videoGame[1]
    Log To Console    ${child}
    Should Not Be Empty    ${child}

    ${id}=  Get Element Text    ${child[0]}
    ${name}=   Get Element Text     ${child[1]}
    ${score}=   Get Element Text    ${child[3]}

    Log To Console    ${id}
    Log To Console    ${name}
    Log To Console    ${score}

    Should Be Equal As Integers    ${id}    1
    Should Be Equal    ${name}  Resident Evil 4
    Should Be Equal As Integers    ${score}     85