# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s spirit.plone.stripe -t test_stripe_product.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src spirit.plone.stripe.testing.SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/spirit/plone/stripe/tests/robot/test_stripe_product.robot
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

Scenario: As a site administrator I can add a Stripe Product
  Given a logged-in site administrator
    and an add Stripe Product form
   When I type 'My Stripe Product' into the title field
    and I submit the form
   Then a Stripe Product with the title 'My Stripe Product' has been created

Scenario: As a site administrator I can view a Stripe Product
  Given a logged-in site administrator
    and a Stripe Product 'My Stripe Product'
   When I go to the Stripe Product view
   Then I can see the Stripe Product title 'My Stripe Product'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add Stripe Product form
  Go To  ${PLONE_URL}/++add++StripeProduct

a Stripe Product 'My Stripe Product'
  Create content  type=Stripe Product  id=my-stripe_product  title=My Stripe Product

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the Stripe Product view
  Go To  ${PLONE_URL}/my-stripe_product
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a Stripe Product with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the Stripe Product title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
