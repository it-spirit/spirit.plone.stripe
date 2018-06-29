# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s spirit.plone.stripe -t test_ct_stripe_product.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src spirit.plone.stripe.testing.SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot src/spirit/plone/stripe/tests/robot/test_ct_stripe_product.robot
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

Scenario: As a site administrator I can add a Stripe Product
  Given a logged-in site administrator
    and an add StripeProduct form
   When I type 'My Stripe Product' into the title field
    and I take a screenshot 'ct_stripe_product_add_form'
    and I submit the form
   Then a Stripe Product with the title 'My Stripe Product' has been created
    and I take a screenshot 'ct_stripe_product_added'
    and I remove the content with id 'my-stripe-product'

Scenario: As a site administrator I can view a Stripe Product
  Given a logged-in site administrator
    and a Stripe Product 'Example Product'
   When I go to the StripeProduct view
   Then I can see the StripeProduct title 'Example Product'
    and I remove the content with id 'example-product'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

a Stripe Product 'Example Product'
  Create content
  ...  type=StripeProduct
  ...  id=example-product
  ...  title=Example Product

an add StripeProduct form
  Go To  ${PLONE_URL}/++add++StripeProduct

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the StripeProduct view
  Go To  ${PLONE_URL}/example-product
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a Stripe Product with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the StripeProduct title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
