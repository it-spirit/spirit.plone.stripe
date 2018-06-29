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
# $ bin/robot -d /tmp -r NONE -l NONE -o NONE src/spirit/plone/stripe/tests/robot/test_ct_stripe_plan.robot
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


*** Test Cases ***************************************************************

Scenario: As a site administrator I can add a Stripe Plan
  Given a logged-in site administrator
    and a StripeProduct 'Example Product'
    and an add StripePlan form
   When I type 'My Stripe Plan' into the title field
    and I take a screenshot 'ct_stripe_plan_add_form'
    and I submit the form
   Then a StripePlan with the title 'My Stripe Plan' has been created
    and I take a screenshot 'ct_stripe_plan_added'
    and I remove the content with id 'example-product'

Scenario: As a site administrator I can view a Stripe Plan
  Given a logged-in site administrator
    and a StripeProduct 'Example Product'
    and a StripePlan 'Example Plan'
   When I go to the StripePlan view
   Then I can see the StripePlan title 'Example Plan'
    and I remove the content with id 'example-product'


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

an add StripePlan form
  Go To  ${PLONE_URL}/example-product/++add++StripePlan

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the StripePlan view
  Go To  ${PLONE_URL}/example-product/example-plan
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a StripePlan with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the StripePlan title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
