*** Settings ***
Documentation   This File contains all the Test Cases and Keywords required for the Code Validation
Library    ../Function.py
Resource    ../Resources/Variables.robot

*** Test Cases ***

Validate Valid Boundary Value
    [Documentation]    This Test case will check the Output function weather it is allowing valid values to
                ...    pass without system error
    ${Output}    Check Boundary Values    ${ValidValue}
    log to console    ${ValidValue}
    log to console    ${Output}

Validate Invalid Boundary Value
    [Documentation]    This Test case will check the Output function weather it is Avoiding Invalid values
                ...    and throwing System Error as expected
    ${Output}    Check Boundary Values    ${InvalidValue}
    log to console    ${InvalidValue}
    log to console    ${Output}

Validate Exact Boundary Value
    [Documentation]    This Test case will check the Output function weather it is Avoiding Exact Invalid values
                ...    and thoughing System Error as expected
    ${Output}    Check Boundary Values    ${ExactBoundaryValue}
    log to console    ${ExactBoundaryValue}
    log to console     ${Output}

Validate Special Character
    [Documentation]    This Test case will check the Criteria to be passed to the Output Function and will Output
                ...    the message accordingly if it is not eligible to get into the funtion
    ${Output}    Check Boundary Values    ${SpecialCharacter}
    log to console    ${SpecialCharacter}
    log to console    ${Output}

Validate String
    [Documentation]    This Test case will check the Criteria to be passed to the Output Function and will Output
                ...    the message accordingly if it is not eligible to get into the funtion
    ${Output}    Check Boundary Values    ${String}
    log to console    ${String}
    log to console    ${Output}

*** Keywords ***
Check Boundary Values
    [Documentation]  This Keyword will validate the given value with the Function under test
    [Arguments]    ${BoundaryNum}
    set suite variable    ${KeywordOutput}    ${EMPTY}
    ${IsInt}    Check Datatype    ${BoundaryNum}
    IF  '${IsInt}' == 'int'
        ${BoundaryNum}    convert to integer    ${BoundaryNum}
        IF  ${BoundaryNum}>100 or ${BoundaryNum}<-100 or ${BoundaryNum}==13
            ${Status}    run keyword and return status    run keyword and expect error    System error    output    ${BoundaryNum}
            IF  ${Status}
                set suite variable    ${KeywordOutput}    System Error
            END
        ELSE
            ${Status}    run keyword and return status    output    ${BoundaryNum}
            IF  ${Status}
                output    ${BoundaryNum}
            ELSE
                set suite variable    ${KeywordOutput}    System Error
            END
        END
    ELSE
        log to console    Enter Integer Values
    END
    [Return]    ${KeywordOutput}

Check Datatype
    [Documentation]    This Keyword will check the data type of a variable
    [Arguments]    ${BoundaryNum}
    ${is int}     Evaluate     type(${BoundaryNum}).__name__
    [Return]    ${is int}