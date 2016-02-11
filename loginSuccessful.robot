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
      Fill in username and password     sprint3r4      WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to login
      Logout page


Login fail with invalid credential with no remember me feature should display Error

      Go to Login by menu
      Fill in username and password    kirkkiat    test
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}


Login fail with valid username and invalid password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password     sprint3r4    test
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}

Login fail with invalid username and valid password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password    kirkkiat    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwd}

Login fail with blank username with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password     ${EMPTY}    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_userempty}

Login fail with blank password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password     kirkkiat      ${EMPTY}
      Unselect Checkbox Remember me feature
      Try to error login    ${error_msg_pwdempty}

Login fail with blank username and password with no remember me feature should display Error
      Go to Login by menu
      Fill in username and password     ${EMPTY}      ${EMPTY}
      Unselect Checkbox Remember me feature
      Try to blank login

Post Blog Entry with title and content
      Go to Login by menu
      Fill in username and password     sprint3r4    WorkingSoftware
      Unselect Checkbox Remember me feature
      Try to login
      Maximize Browser Window
      Click Element    //*[@id="menu-posts"]/a/div[3]
      Wait Until Page Contains    Posts
      Click Element    //*[@id="wpbody-content"]/div[3]/h1/a
      Wait Until Page Contains    Add New Post
      Input Text    title      สรุปผลการดำเนินงานของบจ.และรวมของบริษัทย่อย ประจำปี (F45-3)
      Click Element         content-html
      Input Text    content      สรุปผลการดำเนินงานของบจ.และรวมของบริษัทย่อย (F45-3)
      Scroll Page To Location    0    2000
      Wait Until Page Contains      Uncategorized
      Click Element   //*[@id="category-tabs"]/li[1]/a
      Select Checkbox        in-category-1
      Scroll Page To Location    0    0
      Wait Until Element Is Enabled     save-post
      Click Element     save-post




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

Scroll Page To Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

Go to Login by menu
    Click Element   //*[@id="masthead"]/button
    Wait Until Page Contains    Log in
    Click Element   //*[@id="meta-2"]/ul/li[2]/a

Go to Admin Page
    Click Element   //*[@id="masthead"]/button
    Wait Until Page Contains    Log out
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
    Go To      ${url}
    Wait Until Page Contains    sprint3r4

Logout page
    Click Element   //*[@id="wp-admin-bar-my-account"]/a/img
    Click Element   //*[@id="wp-admin-bar-user-info"]/div/form/button
    Go To      ${url}
    Wait Until Page Contains    sprint3r4
