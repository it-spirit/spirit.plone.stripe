# -*- coding: utf-8 -*-
from spirit.plone.stripe.content.stripe_product import IStripeProduct  # NOQA E501
from spirit.plone.stripe.testing import SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING  # noqa
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from plone.dexterity.interfaces import IDexterityFTI
from zope.component import createObject
from zope.component import queryUtility

import unittest


class StripeProductIntegrationTest(unittest.TestCase):

    layer = SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer['portal']
        setRoles(self.portal, TEST_USER_ID, ['Manager'])

    def test_ct_stripe_product_schema(self):
        fti = queryUtility(IDexterityFTI, name='StripeProduct')
        schema = fti.lookupSchema()
        self.assertEqual(IStripeProduct, schema)

    def test_ct_stripe_product_fti(self):
        fti = queryUtility(IDexterityFTI, name='StripeProduct')
        self.assertTrue(fti)

    def test_ct_stripe_product_factory(self):
        fti = queryUtility(IDexterityFTI, name='StripeProduct')
        factory = fti.factory
        obj = createObject(factory)

        self.assertTrue(
            IStripeProduct.providedBy(obj),
            u'IStripeProduct not provided by {0}!'.format(
                obj,
            ),
        )

    def test_ct_stripe_product_adding(self):
        setRoles(self.portal, TEST_USER_ID, ['Contributor'])
        obj = api.content.create(
            container=self.portal,
            type='StripeProduct',
            id='stripe_product',
        )

        self.assertTrue(
            IStripeProduct.providedBy(obj),
            u'IStripeProduct not provided by {0}!'.format(
                obj.id,
            ),
        )
