*** Settings ***
Library           Selenium2Library

*** Variables ***
${siteurl}        https://www.saucedemo.com/
${currentuser}    standard_user
${currentpass}    secret_sauce
${currenturl}     ${EMPTY}
${inventoryurl}    https://www.saucedemo.com/inventory.html
${confirmationurl}    https://www.saucedemo.com/checkout-complete.html

*** Test Cases ***
ALoginWithValidUser
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${inventoryurl}'    Log to Console    login was successful

BLoginWithInvalidUser
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}+AAA
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'!='${inventoryurl}'    Log to Console    login was NOT successful

CLogoutFromHomePage
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    go back
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${siteurl}'    Log to Console    login was successful
