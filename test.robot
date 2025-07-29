*** Settings ***
Library    SeleniumLibrary   # screenshot_on_failure=False
Library    Dialogs
# Resource

*** Variables ***
${URL}          http://192.168.1.1/
${USERNAME}     admin
${PASSWORD}     admin1234
${BROWSER}      chrome
${DHCP}         True
${ENGLISH}      xpath=//*[@id="languageChoice_en"]
${FRENCH}       xpath=//*[@id="languageChoice_fr"]

*** Test Cases ***
Login To Livebox
    Open Browser To Login Page
    Perform Login
    Go To System Information
    Check Internet Connection Type
    Get Device Information
    Go To WiFi Settings
    Change SSID
    Change WiFi Password
    Save WiFi Configuration
    Go to Settings
    Change Language

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Perform Login
    Wait Until Element Is Visible    id=login_password
    Input Text    id=login_password   ${PASSWORD}
    Wait Until Element Is Visible    id=login_save
    Click Button    id=login_save
    Sleep    5s

Go To System Information
    Wait Until Element Is Visible    css=.iconbar-button.icon.icon-advanced
    Click Element    css=.iconbar-button.icon.icon-advanced
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[@id="systemInformation"]/div
    Click Element    xpath=//*[@id="systemInformation"]/div
    Sleep    5s

Check Internet Connection Type
    Select Frame     xpath=//*[@id="iframeapp"]
    Click Element    css=#tab_information_internet
    Sleep    5s
    ${text}=    Get Text    id=internet_5
    IF    '${text}'=='DHCPv6'
        Log To Console    Pass, its DHCPv6
    ELSE
        Log To Console    Fail, its PPP
    END
    Unselect Frame

Get Device Information
    Select Frame     xpath=//*[@id="iframeapp"]
    Click Element    css=#tab_information_general
    Sleep    5s
    ${type}=     Get Text    id=general_information_2
    ${mac}=      Get Text    id=general_information_5
    ${serial}=   Get Text    id=general_information_4
    Log To Console    '${type}'
    Log To Console    '${serial}'
    Log To Console    '${mac}'
    Unselect Frame

Go To WiFi Settings
    Select Frame    xpath=//*[@id="iframeapp"]
    Wait Until Element Is Visible    id=app_close    timeout=10s
    Click Element    id=app_close
    Unselect Frame
    Wait Until Element Is Visible    css=.iconbar-button.icon.icon-favorites    timeout=10s
    Click Element    css=.iconbar-button.icon.icon-favorites
    Wait Until Element Is Visible    css=#wifiAdvancedTitle_Fav
    Click Element    css=#wifiAdvancedTitle_Fav
    Sleep    5s
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame                     xpath=//iframe[@id="iframeapp"]
    Wait Until Element Is Visible    id=wifi_accesspointboth_link    timeout=10s
    Click Element                    id=wifi_accesspointboth_link
    Unselect Frame

Change SSID
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame                     xpath=//iframe[@id="iframeapp"]
    Wait Until Element Is Visible    id=wifi_private_ssid    timeout=10s
    Clear Element Text    id=wifi_private_ssid
    Input Text           id=wifi_private_ssid    orange_LB5
    Unselect Frame

Change WiFi Password
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame      xpath=//iframe[@id="iframeapp"]
    Wait Until Element Is Visible    id=wifi_private_securitykey    timeout=10s
    Clear Element Text               id=wifi_private_securitykey
    Input Text                       id=wifi_private_securitykey    orange123
    Unselect Frame

Save WiFi Configuration
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame      xpath=//iframe[@id="iframeapp"]
    Wait Until Element Is Visible    id=save    timeout=10s
    Click Element            id=save
    Unselect Frame
    Sleep    5s
Go to Settings
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame                     xpath=//iframe[@id="iframeapp"] 
    Click Element    id=app_close
    Unselect Frame
    Wait Until Element Is Visible    css=.iconbar-button.icon.icon-advanced    timeout=10s
    Click Element    css=.iconbar-button.icon.icon-advanced

Change Language
    Wait Until Element Is Visible    id=localSettings    timeout=10s
    Click Element    id=localSettings
    Wait Until Element Is Visible    xpath=//iframe[@id="iframeapp"]    timeout=10s
    Select Frame    xpath=//iframe[@id="iframeapp"]
    Wait Until Element Is Visible    xpath=//*[@id="languageChoice_en"]    timeout=10s
    ${is_english_selected}=    Get Element Attribute    xpath=//*[@id="languageChoice_en"]    checked
    Run Keyword If    '${is_english_selected}' == 'true'    Click Element    xpath=//label[@for='languageChoice_fr']
    ...    ELSE    Click Element    xpath=//label[@for='languageChoice_en']

    Click Button    id=save
    Unselect Frame
    Sleep    10s