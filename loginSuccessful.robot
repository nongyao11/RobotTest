*** Settings ***
Library    Selenium2Library
Suite Setup   Open Browser    ${url}
Suite Teardown    Close Browser

*** Variables ***
${url}    https://sprint3r4.wordpress.com/

*** Test Cases ***
