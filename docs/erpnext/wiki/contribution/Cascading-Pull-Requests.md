Cascading Pull Requests (CPR) is a strategy to break down a big features in smaller mergeable parts. Smaller parts are easier to merge, review and have fewer bugs.

The goal is to keep un-shipped code to the minimum.

This document explains how to build a feature in a mergeable way using CPRs

#### Planning

These are strategies to help you plan how to implement a feature

1. Make a mockup and get it approved, specially for larger features. This will make sure that the naming and labeling is correct. Fixing a column name or table / DocType name at a later point is going to be very difficult.
1. Break down the feature into smaller phases so that each phase is complete on its own.
1. Start from the data structures and move up to the user interface elements.

#### Execution

1. Build the smallest possible feature that can be merged and is working
1. Keep the feature hidden from the user until it is complete
1. Create a new branch as soon as a phase is completed, so you can continue working even when your earlier phases are not merged.
1. As soon as your phases get merged, rebase with `develop`.

#### Caveats

1. Of course, a gotcha is that almost always, the PRs are not mutually exclusive. This means that the contributor has to take care to keep rebasing his development branch to reflect the changes of his previously merged PR (and any other changes in the meantime).
1. As a result, this approach works better if the individual PRs are merged at a reasonable pace. 
1. It also helps if the individual steps are defined beforehand, for the maintainers to understand the effects that may not clear in the early stages.
1. It should be noted that **this does not imply that you'd have to create a new branch for every PR**. Cascading suggests separation of PRs, not necessarily branches. You can continue developing and push all your commits to the same feature branch and create PRs along the way. Simply rebase the branch as your previous PRs get merged.

#### Example

If you are working on implementing Global Search, here are suggested phases

1. Create Index Table
1. Build Index table for existing data
1. Update Index table for new inserts and updates
1. Refactor search bar
1. Show global search results in the new search bar
1. Make a modal to show all results in a classified way.