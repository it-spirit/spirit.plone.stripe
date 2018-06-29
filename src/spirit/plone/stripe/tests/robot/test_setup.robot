# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s spirit.plone.stripe -t test_setup.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src spirit.plone.stripe.testing.SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/spirit/plone/stripe/tests/robot/test_setup.robot
#
# See the http://docs.plone.org for further details (search for robot
# framework).
#
# ============================================================================

*** Settings *****************************************************************

Resource  keywords.robot


Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test cases ***

Show how to activate the add-on
    Enable autologin as  Manager
    Go to  ${PLONE_URL}/prefs_install_products_form

    Page should contain element  xpath=//*[@value='spirit.plone.stripe']
    Assign id to element
    ...  xpath=//*[@value='spirit.plone.stripe']/ancestor::li
    ...  addons-spirit-plone-stripe
    Assign id to element
    ...  xpath=//*[@value='spirit.plone.stripe']/ancestor::ul/parent::*/parent::*
    ...  addons-enabled

    Highlight  addons-spirit-plone-stripe
    Capture and crop page screenshot
    ...  setup_select_add_on.png
    ...  id=addons-enabled

    Click button  xpath=//*[@value='spirit.plone.stripe']/ancestor::form//input[@type='submit']

    Page should contain element  xpath=//*[@value='spirit.plone.stripe']

    Assign id to element
    ...  xpath=//*[@value='spirit.plone.stripe']/ancestor::li
    ...  addons-spirit-plone-stripe
    Assign id to element
    ...  xpath=//*[@value='spirit.plone.stripe']/ancestor::ul/parent::*/parent::*
    ...  addons-enabled

    Highlight  addons-spirit-plone-stripe
    Capture and crop page screenshot
    ...  setup_select_add_on_installable.png
    ...  id=addons-enabled

    Click button  xpath=//*[@value='spirit.plone.stripe']/ancestor::form//input[@type='submit']
