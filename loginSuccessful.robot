*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${url}
Suite Teardown    Close Browser

*** Variables ***

${url}    https://sprint3r4.wordpress.com/
${_userlogin}    sprint3r4
${_password}    WorkingSoftware


*** Test Cases ***
Login success with no remember me feature should display welcome page
      Go to Login by menu
      Fill in username and password   sprint3r4    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to login
      Logout page


Login fail with invalid credential with no remember me feature should display Error
    Go to Login by menu
    Fill in username and password   test    test
    Unselect Checkbox Remember me feature
    Try to error login

*** Keywords ***
Go to Login by menu
    Click Element   //*[@id="masthead"]/button
    Click Element   //*[@id="meta-2"]/ul/li[2]/a

Fill in username and password
    [arguments]    ${_username}    ${_password}
    Input Text    user_login    ${_userlogin}
    Input Password    user_pass   ${_password}

Unselect Checkbox Remember me feature
    Unselect Checkbox    rememberme

Try to login
    Click Element    wp-submit
    Wait Until Page Contains    Welcome to WordPress.com!

Try to error login
    Click Element    wp-submit
    Wait Until Page Contains    ERROR: The password you entered for the email or username ${_userlogin} is incorrect.

Logout page
    Click Element   //*[@id="wp-admin-bar-my-account"]/a/img
    Click Element   //*[@id="wp-admin-bar-user-info"]/div/form/button
    Go To      ${url}
