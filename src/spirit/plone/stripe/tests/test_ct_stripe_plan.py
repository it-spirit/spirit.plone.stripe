# -*- coding: utf-8 -*-
from spirit.plone.stripe.content.stripe_plan import IStripePlan  # NOQA E501
from spirit.plone.stripe.testing import SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING  # noqa
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from plone.dexterity.interfaces import IDexterityFTI
from zope.component import createObject
from zope.component import queryUtility

import unittest


class StripePlanIntegrationTest(unittest.TestCase):

    layer = SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer['portal']
        setRoles(self.portal, TEST_USER_ID, ['Manager'])
        portal_types = self.portal.portal_types
        parent_id = portal_types.constructContent(
            'StripeProduct',
            self.portal,
            'parent_id',
            title='Parent container',
        )
        self.parent = self.portal[parent_id]

    def test_ct_stripe_plan_schema(self):
        fti = queryUtility(IDexterityFTI, name='StripePlan')
        schema = fti.lookupSchema()
        self.assertEqual(IStripePlan, schema)

    def test_ct_stripe_plan_fti(self):
        fti = queryUtility(IDexterityFTI, name='StripePlan')
        self.assertTrue(fti)

    def test_ct_stripe_plan_factory(self):
        fti = queryUtility(IDexterityFTI, name='StripePlan')
        factory = fti.factory
        obj = createObject(factory)

        self.assertTrue(
            IStripePlan.providedBy(obj),
            u'IStripePlan not provided by {0}!'.format(
                obj,
            ),
        )

    def test_ct_stripe_plan_adding(self):
        setRoles(self.portal, TEST_USER_ID, ['Contributor'])
        obj = api.content.create(
            container=self.parent,
            type='StripePlan',
            id='stripe_plan',
        )

        self.assertTrue(
            IStripePlan.providedBy(obj),
            u'IStripePlan not provided by {0}!'.format(
                obj.id,
            ),
        )
