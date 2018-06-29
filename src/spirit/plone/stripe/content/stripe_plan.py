# -*- coding: utf-8 -*-
"""A plan for an existing stripe product."""

from plone.dexterity.content import Container
from plone.supermodel import model
from zope.interface import implementer


class IStripePlan(model.Schema):
    """Marker interface and Dexterity Python Schema for StripePlan."""


@implementer(IStripePlan)
class StripePlan(Container):
    """A plan for an existing stripe product."""
