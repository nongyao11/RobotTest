*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${url}
Suite Teardown    Close Browser

*** Variables ***

${url}    https://sprint3r4.wordpress.com/
${_userlogin}    sprint3r4
${_password}    WorkingSoftware


*** Test Cases ***
Login Success with no remember me feature should display welcome page
      Go to Login by menu
      Fill in valid username and password
      Disable Remember me feature
      Try to login


*** Keywords ***
Go to Login by menu
    Click Element   //*[@id="masthead"]/button
    Click Element   //*[@id="meta-2"]/ul/li[2]/a
Fill in valid username and password
    Input Text    user_login    ${_userlogin}
    Input Password    user_pass   ${_password}
Disable Remember me feature
    click Element    rememberme

Try to login
    Click Element    wp-submit
    Wait Until Page Contains    Welcome to WordPress.com!
