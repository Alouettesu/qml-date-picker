name: Pull Request
description: Submit a pull request to contribute changes
title: "[PR] "
body:
  - type: markdown
    attributes:
      value: |
        Thanks for contributing! Please fill out the details below.
  - type: textarea
    id: description
    attributes:
      label: Description
      description: Describe the changes you've made
      placeholder: Describe your changes...
    validations:
      required: true
  - type: textarea
    id: related-issues
    attributes:
      label: Related Issues
      description: Link any related issues (e.g., Fixes #123)
      placeholder: "Fixes #"
  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      options:
        - label: I have tested my changes
          required: true
        - label: I have updated the documentation
          required: false
        - label: I have added comments to complex code
          required: false
        - label: My code follows the project's style guidelines
          required: true
