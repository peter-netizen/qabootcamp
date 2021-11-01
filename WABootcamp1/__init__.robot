*** Settings ***
Library           Selenium2Library

*** Keywords ***
Goin
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
