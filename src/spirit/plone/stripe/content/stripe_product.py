# -*- coding: utf-8 -*-
"""A stripe based product."""

from plone.dexterity.content import Container
from plone.supermodel import model
from zope.interface import implementer


class IStripeProduct(model.Schema):
    """Marker interface and Dexterity Python Schema for StripeProduct."""


@implementer(IStripeProduct)
class StripeProduct(Container):
    """A stripe based product."""
