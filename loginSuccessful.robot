*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${url}
Suite Teardown    Close Browser

*** Variables ***

${url}    https://sprint3r4.wordpress.com/
${_userlogin}    sprint3r4
${_password}    WorkingSoftware


*** Test Cases ***
Login Successful
      Click Element   //*[@id="masthead"]/button
      Click Element   //*[@id="meta-2"]/ul/li[2]/a
      Input Text    user_login    ${_userlogin}
      Input Password    user_pass   ${_password}
