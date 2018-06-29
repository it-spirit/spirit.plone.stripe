# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s spirit.plone.stripe -t test_stripeinterval.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src spirit.plone.stripe.testing.SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/spirit/plone/stripe/tests/robot/test_stripeinterval.robot
#
# See the http://docs.plone.org for further details (search for robot
# framework).
#
# ============================================================================

*** Settings *****************************************************************

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test Cases ***************************************************************

Scenario: As a site administrator I can add a StripeInterval
  Given a logged-in site administrator
    and an add StripePlan form
   When I type 'My StripeInterval' into the title field
    and I submit the form
   Then a StripeInterval with the title 'My StripeInterval' has been created

Scenario: As a site administrator I can view a StripeInterval
  Given a logged-in site administrator
    and a StripeInterval 'My StripeInterval'
   When I go to the StripeInterval view
   Then I can see the StripeInterval title 'My StripeInterval'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add StripePlan form
  Go To  ${PLONE_URL}/++add++StripePlan

a StripeInterval 'My StripeInterval'
  Create content  type=StripePlan  id=my-stripeinterval  title=My StripeInterval

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the StripeInterval view
  Go To  ${PLONE_URL}/my-stripeinterval
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a StripeInterval with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the StripeInterval title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
