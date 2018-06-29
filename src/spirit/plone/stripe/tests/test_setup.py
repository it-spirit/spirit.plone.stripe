# -*- coding: utf-8 -*-
"""Setup tests for this package."""
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from spirit.plone.stripe.testing import SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING  # noqa

import unittest


class TestSetup(unittest.TestCase):
    """Test that spirit.plone.stripe is properly installed."""

    layer = SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer['portal']
        self.installer = api.portal.get_tool('portal_quickinstaller')

    def test_product_installed(self):
        """Test if spirit.plone.stripe is installed."""
        self.assertTrue(self.installer.isProductInstalled(
            'spirit.plone.stripe'))

    def test_browserlayer(self):
        """Test that ISpiritPloneStripeLayer is registered."""
        from spirit.plone.stripe.interfaces import (
            ISpiritPloneStripeLayer)
        from plone.browserlayer import utils
        self.assertIn(
            ISpiritPloneStripeLayer,
            utils.registered_layers())


class TestUninstall(unittest.TestCase):

    layer = SPIRIT_PLONE_STRIPE_INTEGRATION_TESTING

    def setUp(self):
        self.portal = self.layer['portal']
        self.installer = api.portal.get_tool('portal_quickinstaller')
        roles_before = api.user.get_roles(TEST_USER_ID)
        setRoles(self.portal, TEST_USER_ID, ['Manager'])
        self.installer.uninstallProducts(['spirit.plone.stripe'])
        setRoles(self.portal, TEST_USER_ID, roles_before)

    def test_product_uninstalled(self):
        """Test if spirit.plone.stripe is cleanly uninstalled."""
        self.assertFalse(self.installer.isProductInstalled(
            'spirit.plone.stripe'))

    def test_browserlayer_removed(self):
        """Test that ISpiritPloneStripeLayer is removed."""
        from spirit.plone.stripe.interfaces import \
            ISpiritPloneStripeLayer
        from plone.browserlayer import utils
        self.assertNotIn(
            ISpiritPloneStripeLayer,
            utils.registered_layers())
