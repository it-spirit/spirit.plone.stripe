# -*- coding: utf-8 -*-
from spirit.plone.stripe.content.stripe_interval import IStripeinterval  # NOQA E501
from spirit.plone.stripe.testing import SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING  # noqa
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from plone.dexterity.interfaces import IDexterityFTI
from zope.component import createObject
from zope.component import queryUtility

import unittest


class StripeIntervalIntegrationTest(unittest.TestCase):

    layer = SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer['portal']
        setRoles(self.portal, TEST_USER_ID, ['Manager'])
        portal_types = self.portal.portal_types
        parent_id = portal_types.constructContent(
            'StripePlan',
            self.portal,
            'parent_id',
            title='Parent container',
        )
        self.parent = self.portal[parent_id]

    def test_ct_stripe_interval_schema(self):
        fti = queryUtility(IDexterityFTI, name='StripeInterval')
        schema = fti.lookupSchema()
        self.assertEqual(IStripeinterval, schema)

    def test_ct_stripe_interval_fti(self):
        fti = queryUtility(IDexterityFTI, name='StripeInterval')
        self.assertTrue(fti)

    def test_ct_stripe_interval_factory(self):
        fti = queryUtility(IDexterityFTI, name='StripeInterval')
        factory = fti.factory
        obj = createObject(factory)

        self.assertTrue(
            IStripeinterval.providedBy(obj),
            u'IStripeinterval not provided by {0}!'.format(
                obj,
            ),
        )

    def test_ct_stripe_interval_adding(self):
        setRoles(self.portal, TEST_USER_ID, ['Contributor'])
        obj = api.content.create(
            container=self.parent,
            type='StripeInterval',
            id='stripeinterval',
        )

        self.assertTrue(
            IStripeinterval.providedBy(obj),
            u'IStripeinterval not provided by {0}!'.format(
                obj.id,
            ),
        )
