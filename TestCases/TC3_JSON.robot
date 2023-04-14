*** Settings ***
Library    JSONLibrary
Library    os
Library    Collections

*** Test Cases ***
TestCase1:
    ${json_obj}=    Load Json From File     jsonfilewithhierarchy-100.json

    ${id}=  Get Value From Json    ${json_obj}  $.feeds[0].id
    ${id_str}=  Convert To String    ${id[0]}
    Should Be Equal    ${id_str}     2140

    ${multimedia_id}=  Get Value From Json    ${json_obj}  $.feeds[0].multiMedia[0].id
    ${multimedia_id_str}=  Convert To String    ${multimedia_id[0]}
    Should Be Equal    ${multimedia_id_str}      3240