ERPNext is now being built for over 10 years and has tons of built-in features based on experiences for more than hundreds of businesses. When you start building a new feature, make sure you do your ground work right. It is necessary that you spend at least a few days playing with "using" the system, and understanding how features and workflows are designed in ERPNext.

### 1. Work with the User

When you start building a new feature, start with a broad discussion with the end user. Understand the need from the end user's point of view. Ask a lot of questions as they will help you clear your thoughts and also help you identify how the feature must be integrated with the rest of the product.

Don't start developing on the same day. Prepare a note and sleep over your thoughts for at least one day.

### 2. Using Existing Models v/s Making New Models

ERPNext has a lot of workflow tools on top of the models that may be used to fit your requirement. Generally, extending an existing feature is always better than making new models. But this is not always true. A good way to decide this is on the basis of naming of your model. Is it synonymous to an existing model, or is it completely new? 

For example if you are planning to start a new model to track students, you could decide to use the Customer model and add a few fields. But, a Student is not synonymous to Customer, so its best to make a separate model for this. See naming guidelines for more details, but always remember that *words* are the most important way of communicating with users and the biggest contributor to a good user experience.

_Example: [#9949 Product Life Management PLM](https://github.com/frappe/erpnext/issues/9949)_

### 3. User Experience Consistency

ERPNext also has thousands of users, and all these users are going to discover and use the feature you are going to build. The most important thing for these users is that your new feature must *look and behave* in a consistent manner to the existing features, so that the user does not have to learn a new *way* of doing things. This means how things are named, how objects are laid out on the screen etc.

_Example: [#7538 [Feature] Customer and Supplier as one Party](https://github.com/frappe/erpnext/issues/7538)_

### 4. Start with a GitHub Issue

Summarize your discussion and start with a GitHub Issue. Also post your design with a tag `[Proposal]` on both GitHub and discuss. 

In your Issue, make sure to mention

- Feature Goals (Use cases)
- Additional DocTypes and fields (with fieldtype, etc) if any.
- Discovery (how will the user find the feature you are building)
- Screen Mockups with buttons and any custom UI if any
- Business Logic
  - Validations
  - Calculations
  - Logs
- Links to existing DocTypes
- Reports

_Example: [#6859 Show Unallocated amounts received/paid in Customer/Supplier](https://github.com/frappe/erpnext/issues/6859)_

### 5. Get Feedback from a Maintainer

Make sure you get at least some feedback from the maintainers before you start building your feature, since this will help the maintainers when they have to merge the issue.

If your contribution is very significant, don't hesitate to @-tag or ask a maintainer for a call. A good way to select who to call is based on who has worked on similar or adjacent features to the one you are proposing.

[Here is the list of module maintainers you can contact when you have your proposal ready](https://github.com/frappe/erpnext/wiki/Module-Maintainers)

### 6. Regional features and compliance

ERPNext monolith will be broken into more modular and smaller applications. So any contribution related to regional requirements is better served as a separate application on [Frappe Cloud Marketplace](https://frappecloud.com/marketplace). 

[ERPNext: Breaking the Monolith & Way Forward' by Nabin Hait | ERPNext Conference 2021
](https://www.youtube.com/watch?v=207S3celYqA)

### Note about formatting/style changes

> Note: Contributions including Style only and Requirements update fixes will not be directly entertained. Raise an Issue explaining it's a necessity in order for it to be considered. Refrain from changing styles for the whole file as it renders `git blame` useless or makes it harder to debug issues.   

_Example: [#13384 [Enhancement] Work Order Material Consumption](https://github.com/frappe/erpnext/pull/13384)_

