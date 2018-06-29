# -*- coding: utf-8 -*-
from plone.app.contenttypes.testing import PLONE_APP_CONTENTTYPES_FIXTURE
from plone.app.robotframework.testing import REMOTE_LIBRARY_BUNDLE_FIXTURE
from plone.app.testing import applyProfile
from plone.app.testing import FunctionalTesting
from plone.app.testing import IntegrationTesting
from plone.app.testing import PloneSandboxLayer
from plone.testing import z2

import spirit.plone.stripe


class SpiritPloneStripeLayer(PloneSandboxLayer):

    defaultBases = (PLONE_APP_CONTENTTYPES_FIXTURE,)

    def setUpZope(self, app, configurationContext):
        # Load any other ZCML that is required for your tests.
        # The z3c.autoinclude feature is disabled in the Plone fixture base
        # layer.
        self.loadZCML(package=spirit.plone.stripe)

    def setUpPloneSite(self, portal):
        applyProfile(portal, 'spirit.plone.stripe:default')


SPIRIT_PLONE_STRIPE_FIXTURE = SpiritPloneStripeLayer()


SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING = IntegrationTesting(
    bases=(SPIRIT_PLONE_STRIPE_FIXTURE,),
    name='SpiritPloneStripeLayer:IntegrationTesting',
)


SPIRIT_PLONE_STRIPE_FUNCTIONAL_TESTING = FunctionalTesting(
    bases=(SPIRIT_PLONE_STRIPE_FIXTURE,),
    name='SpiritPloneStripeLayer:FunctionalTesting',
)


SPIRIT_PLONE_STRIPE_ACCEPTANCE_TESTING = FunctionalTesting(
    bases=(
        SPIRIT_PLONE_STRIPE_FIXTURE,
        REMOTE_LIBRARY_BUNDLE_FIXTURE,
        z2.ZSERVER_FIXTURE,
    ),
    name='SpiritPloneStripeLayer:AcceptanceTesting',
)
