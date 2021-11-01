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
DSortProducts
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${inventoryurl}'    wait until element is visible    //*[@id="header_container"]/div[2]/div[2]/span/select
    Run keyword if    '${currenturl}'=='${inventoryurl}'    Click Element    //*[@id="header_container"]/div[2]/div[2]/span/select
    Run keyword if    '${currenturl}'=='${inventoryurl}'    Select from List by Value    //*[@id="header_container"]/div[2]/div[2]/span/select    lohi
    Capture Page Screenshot
    List selection should be    //*[@id="header_container"]/div[2]/div[2]/span/select    lohi

EAddMultipleItems
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${inventoryurl}'    click button    id=add-to-cart-sauce-labs-onesie
    sleep    2
    Run keyword if    '${currenturl}'=='${inventoryurl}'    click button    id=add-to-cart-sauce-labs-backpack
    click element    //*[@id="shopping_cart_container"]/a

FAddSpecificItem
    Open Browser    ${siteurl}    chrome
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${inventoryurl}'    click button    id=add-to-cart-sauce-labs-onesie
    sleep    2
    click element    //*[@id="shopping_cart_container"]/a
    Wait Until Element Is Visible    id=remove-sauce-labs-onesie
    Capture Page Screenshot

GCompletePurchase
    Open Browser    ${siteurl}    chrome
    Maximize Browser Window
    Input Text    id=user-name    ${currentuser}
    Input Text    id=password    ${currentpass}
    click button    id=login-button
    sleep    5
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${inventoryurl}'    click button    id=add-to-cart-sauce-labs-onesie
    sleep    2
    click element    //*[@id="shopping_cart_container"]/a
    Wait Until Element Is Visible    id=remove-sauce-labs-onesie
    sleep    2
    click button    id=checkout
    Input Text    id=first-name    peter
    Input Text    id=last-name    borrego
    Input Text    id=postal-code    83000
    sleep    2
    click button    id=continue
    sleep    2
    click button    id=finish
    ${currenturl}=    Execute Javascript    return window.location.href
    Run keyword if    '${currenturl}'=='${confirmationurl}'    Log to Console    purchase was completed
