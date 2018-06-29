# -*- coding: utf-8 -*-
"""A payment interval for a product plan."""

from plone.dexterity.content import Item
from plone.supermodel import model
from zope.interface import implementer


class IStripeinterval(model.Schema):
    """Marker interface and Dexterity Python Schema for Stripeinterval."""


@implementer(IStripeinterval)
class Stripeinterval(Item):
    """A payment interval for a product plan."""
