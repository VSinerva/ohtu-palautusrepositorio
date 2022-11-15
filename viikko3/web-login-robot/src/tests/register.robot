*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Go To Register Page And Reset Application

*** Test Cases ***
Register With Valid Username And Password
    Set Username  valid
    Set Password  valid123
    Set Password Confirm  valid123
    Submit Credentials
    Register Should Succeed

Register With Too Short Username And Valid Password
    Set Username  aa
    Set Password  valid123
    Set Password Confirm  valid123
    Submit Credentials
    Register Should Fail With Message  Username must be at least 3 characters

Register With Valid Username And Too Short Password
    Set Username  valid
    Set Password  a1 
    Set Password Confirm  a1
    Submit Credentials
    Register Should Fail With Message  Password must be at least 8 characters

Register With Nonmatching Password And Password Confirmation
    Set Username  valid
    Set Password  valid123
    Set Password Confirm  valid456
    Submit Credentials
    Register Should Fail With Message  Passwords don't match

*** Keywords ***
Register Should Succeed
    Welcome Page Should Be Open

Register Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}

Submit Credentials
    Click Button  Register

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirm
    [Arguments]  ${password}
    Input Password  password_confirmation  ${password}

Go To Register Page And Reset Application
    Go To Register Page
    Reset Application
