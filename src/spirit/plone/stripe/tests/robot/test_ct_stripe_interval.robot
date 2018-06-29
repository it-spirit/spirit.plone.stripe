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
    and a StripeProduct 'Example Product'
    and a StripePlan 'Example Plan'
    and an add StripeInterval form
   When I type 'My Stripe Interval' into the title field
    and I submit the form
   Then a StripeInterval with the title 'My Stripe Interval' has been created

Scenario: As a site administrator I can view a StripeInterval
  Given a logged-in site administrator
    and a StripeProduct 'Example Product'
    and a StripePlan 'Example Plan'
    and a StripeInterval 'Example Interval'
   When I go to the StripeInterval view
   Then I can see the StripeInterval title 'Example Interval'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

a StripeProduct 'Example Product'
  Create content
  ...  type=StripeProduct
  ...  id=example-product
  ...  title=Example Product

a StripePlan 'Example Plan'
  Create content
  ...  type=StripePlan
  ...  id=example-plan
  ...  title=Example Plan
  ...  container=/plone/example-product

a StripeInterval 'Example Interval'
  Create content
  ...  type=StripeInterval
  ...  id=example-interval
  ...  title=Example Interval
  ...  container=/plone/example-product/example-plan

an add StripeInterval form
  Go To  ${PLONE_URL}/example-product/example-plan/++add++StripeInterval

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the StripeInterval view
  Go To  ${PLONE_URL}/example-product/example-plan/example-interval
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a StripeInterval with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the StripeInterval title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
