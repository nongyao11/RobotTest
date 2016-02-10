*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${test}
Suite Teardown    Close Browser

*** Variables ***
${test}    https://sprint3r4.wordpress.com/

*** Test Cases ***
