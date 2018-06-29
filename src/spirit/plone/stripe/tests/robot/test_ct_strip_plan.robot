# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s spirit.plone.stripe -t test_stripe_plan.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src spirit.plone.stripe.testing.SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/spirit/plone/stripe/tests/robot/test_stripe_plan.robot
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

Scenario: As a site administrator I can add a Stripe Plan
  Given a logged-in site administrator
    and an add Stripe Product form
   When I type 'My Stripe Plan' into the title field
    and I submit the form
   Then a Stripe Plan with the title 'My Stripe Plan' has been created

Scenario: As a site administrator I can view a Stripe Plan
  Given a logged-in site administrator
    and a Stripe Plan 'My Stripe Plan'
   When I go to the Stripe Plan view
   Then I can see the Stripe Plan title 'My Stripe Plan'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add Stripe Product form
  Go To  ${PLONE_URL}/++add++StripeProduct

a Stripe Plan 'My Stripe Plan'
  Create content  type=Stripe Product  id=my-stripe_plan  title=My Stripe Plan

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the Stripe Plan view
  Go To  ${PLONE_URL}/my-stripe_plan
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a Stripe Plan with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the Stripe Plan title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
