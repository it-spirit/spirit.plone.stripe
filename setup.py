# -*- coding: utf-8 -*-
"""Installer for the spirit.plone.stripe package."""

from setuptools import find_packages
from setuptools import setup


version = '0.1.dev0'
description = 'Stripe integration for Plone.'
long_description = '\n\n'.join([
    open('README.rst').read(),
    open('CONTRIBUTORS.rst').read(),
    open('CHANGES.rst').read(),
])

install_requires = [
    'setuptools',
    # -*- Extra requirements: -*-
    'plone.api',
    'plone.app.dexterity',
    'Products.GenericSetup>=1.8.2',
]

testfixture_requires = [
]


setup(
    name='spirit.plone.stripe',
    version=version,
    description=description,
    long_description=long_description,
    # Get more from https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        'Development Status :: 4 - Beta',
        'Environment :: Web Environment',
        'Framework :: Plone',
        'Framework :: Plone :: 5.0',
        'Framework :: Plone :: 5.1',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License v2 (GPLv2)',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.7',
    ],
    keywords='Python Plone',
    author='it-spirit',
    author_email='development@it-spir.it',
    url='https://github.com/it-spirit/spirit.plone.stripe',
    download_url='https://pypi.python.org/pypi/spirit.plone.stripe',
    license='GPL version 2',
    packages=find_packages('src', exclude=['ez_setup']),
    namespace_packages=['spirit', 'spirit.plone'],
    package_dir={'': 'src'},
    include_package_data=True,
    zip_safe=False,
    install_requires=install_requires,
    extras_require={
        'testfixture': testfixture_requires,
        'test': [
            'plone.app.robotframework[debug]',
            'plone.app.testing',
            'robotframework-selenium2screenshots',
        ],
    },
    entry_points="""
    [z3c.autoinclude.plugin]
    target = plone
    """,
)
