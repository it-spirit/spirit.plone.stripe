*** Settings ***

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot
Resource  Selenium2Screenshots/keywords.robot


*** Keywords ***

I remove the content with id '${id}'
  Delete content  /plone/${id}


I take a screenshot '${name}'
  Capture and crop page screenshot
  ...  ${name}.png
  ...  css=body
