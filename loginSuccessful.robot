*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${url}
Suite Teardown    Close Browser

*** Variables ***

${url}    https://sprint3r4.wordpress.com/
${error_msg_pwd}    ERROR: The password you entered for the email or username
${error_msg_userempty}    ERROR: The email or username field is empty.
${error_msg_pwdempty}     ERROR: The password field is empty.
*** Test Cases ***
Login success with no remember me feature should display welcome page
      Go to Login by menu
      Fill in username and password   sprint3r4    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to login
      Logout page


Login fail with invalid credential with no remember me feature should display Error

      Go to Login by menu
      Fill in username and password   nongyao    test
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}


Login fail with valid username and invalid password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password   sprint3r4    test
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}

Login fail with invalid username and valid password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password   nongyao    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}

Login fail with blank username with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password   ${EMPTY}    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_userempty}

Login fail with blank password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password    nongyao      ${EMPTY}
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwdempty}

Login fail with blank username and password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password     ${EMPTY}      ${EMPTY}
      Unselect Checkbox Remember me feature
      Try to blank login


      # Login success with remember me feature should display welcome page
      #       Go to Login by menu
      #       Fill in username and password   sprint3r4    WorkingSoftware
      #       Select Checkbox Remember me feature
      #       Try to login
      #       Close Browser
      #       Open Browser    ${url}
      #       Wait Until Page Contains    sprint3r4
      #       Go to Admin Page
      #       Logout page

*** Keywords ***
Go to Login by menu
    Click Element   //*[@id="masthead"]/button
    Wait Until Page Contains    Recent Comments
    Click Element   //*[@id="meta-2"]/ul/li[2]/a

Go to Admin Page
    Click Element   //*[@id="masthead"]/button
    Wait Until Page Contains    Recent Comments
    Click Element   //*[@id="meta-2"]/ul/li[1]/a

Fill in username and password
    [arguments]    ${_username}    ${_password}
    Input Text    user_login    ${_username}
    Input Password    user_pass   ${_password}

Unselect Checkbox Remember me feature
    Unselect Checkbox    rememberme

Select Checkbox Remember me feature
    Select Checkbox    rememberme

Try to login
    Click Element    wp-submit
    Wait Until Page Contains    Welcome to WordPress.com!

Try to error login
    [arguments]      ${error_msg}
    Click Element    wp-submit
    Wait Until Page Contains     ${error_msg}
    Go To      ${url}
    Wait Until Page Contains    sprint3r4

Try to blank login
    Click Element    wp-submit
    Checkbox Should Be Selected     rememberme

Logout page
    Click Element   //*[@id="wp-admin-bar-my-account"]/a/img
    Click Element   //*[@id="wp-admin-bar-user-info"]/div/form/button
    Go To      ${url}
    Wait Until Page Contains    sprint3r4
