# Contributing to DayScheduleView

Thank you for using and contributing to DayScheduleView. Please trust us, we
welcome you and want you and your contributions here. Whether the contributions
are bug fixes, spelling corrections, documentation fixes, or new features, we
welcome and look forward to any and all contributions, and we want you to feel
empowered to make them.

If you have not reviewed our [Code of Conduct](CODE_OF_CONDUCT.md), we
encourage you to take a moment to do so. If you feel unwelcome or feel that
any that you have been treated badly by us or others in this project, please
do not hesitate to contact us as support@naked.software.

## How to Contribute

### Asking Questions

Contributing is not limited to implementing bug fixes or adding new features
to DayScheduleView. Asking questions is a legitimate way of contributing by
helping us to identify areas where we may not have thoroughly documented
DayScheduleView or to identify holes in our implementation. We encourage
questions and civil discussion.

If you have a question, please ask us. You can submit questions on the GitHub
[Issues](https://github.com/nakedsoftware/DayScheduleView/issues) page. We
will make every attempt to answer your question or begin a discussion with
you about it as promptly as possible.

### Reporting Bugs

Our code is not perfect (well, actually, mine is). We try to test the majority
of the usage scenarios, but we'll bet our children that there are some that we
are going to miss (and I'm sure that we'll think fondly of our children a few
years after you come to collect them). If you have found a bug, or what you
think is a bug, please let us know and we will make every attempt to fix the
bug if we can. Bugs should be reported on the GitHub [Issues](https://github.com/nakedsoftware/DayScheduleView/issues)
page. We will review, triage, and proritize all bugs and will attempt to fix
the ones that we can as soon as we can.

Please note that in certain cases, we may choose not to fix a bug. There is
always the possibility that a bug exists, but fixing it may not make sense or
may cause complications for the greater community, so we may choose to leave
it the way that it is. In that case, we will happily work with you to find an
alternative scenario or an alternative implementation that will help you to
work around the defect.

#### Before Submitting a Bug Report

* Please check the open issues (and possibly the closed issues as well) to
  determine if someone else has reported the same issue.
* Check the [Changelog](../CHANGELOG.md) for the latest release to ensure
  that your bug has not already been addressed in a newer release if you are
  not using the latest version.

#### Submitting a Good Bug Report

Supporting customers remotely without access to your program is hard. It helps
to have as much information as possible. Please do your best to provide a very
detailed explanation of the issue and how it is being caused in your
application.

Please provide us with the following information when reporting a potential
bug:

* What is the behavior or outcome that you are expecting?
* What is the behavior or outcome that you are experiencing?
* Which version of DayScheduleView are you using?
* Are you consuming DayScheduleView using Carthage or CocoaPods?
* Which iOS version are you seeing the problem in?
* Which version of Xcode are you using?
* Are you seeing the error on a device or a simulator or both?
* Does the issue happen in both portrait and landscape orientation in the
  device or simulator?
* Do you have any sample code or a sample project that you can share that will
  allow us to reproduce and debug the issue?
* Do you have any screenshots that you can share?

The more information that you can provide us, the easier it will make it for
us to try to reproduce, debug, and resolve your issue, or to provide guidance
for working around the issue.

### Suggesting New Features

We have done our best to capture 80-90% of the applicable use cases that we
could think of for DayScheduleView, but undoubtedly, once you start using it
you will come across a use case that would be valuable to you that we missed.
Or perhaps we are not exposing the right API for your use and you would like
something that better fits your problem. We're cool with that! We built
DayScheduleView because we needed it, but we get really excited when we find
out that something that we open sourced is something that you can use, and we
can't wait to install your application and see our code running in it!

If there's a new feature that you would like to see implemented, or a new
feature that you might be interested in implementing yourself, then let's talk
about it.

#### First, Tell Us About the Feature

Do you have an idea for a new feature? Fantastic! Tell us about it. Start by
opening an issue on the [GitHub Issues](https://github.com/nakedsoftware/DayScheduleView/issues)
page. We can use the conversation history of the issue to discuss it, get
clarity on the requirements, and collaborate on how it can be implemented. We
can both ask questions of each other and have a really great time making the
framework better.

However, please keep in mind, as caretakers of DayScheduleView, we really,
really want to accept all suggestions for making it better. However, there
will probably be certain times where a feature just doesn't make sense or
it doesn't make sense for the greater community that uses DayScheduleView. We
don't want to bring in a new feature that makes life for you better while
preventing others from being able to continue to use DayScheduleView. As
*product owners*, we have a responsibility to all of our users, and we will
make every attempt to be diplomatic about that as well. We do not want to
protect the user base while alienating you and driving you away. That is not
our goal either.

But even if we can't include it in the greater product, let us talk about it
in an issue. We are happy to collaborate with you on the feature in your own
fork. And you never know, maybe once we get a little further on in the
implementation, we may reconsider our earlier decision that your feature
does not make sense for the greater user base and we will ask you to submit
a pull request.

#### Implement the Change

We do our best to maintain and enhance DayScheduleView, but sometimes we just
cannot commit to certain features. But if you have the time and the interest,
we will happily work with you on it.

We use the [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
to develop and manage DayScheduleView at a repository level. We encourage you
to learn about this workflow and work within it when making changes and
submitting pull requests.

First, the `master` branch is our main code line and represents the current,
active release of DayScheduleView. We do our best to ensure that the source
code on `master` always compiles and works. The `develop` branch represents
active development on the next version of DayScheduleView. We try to ensure
that `develop` always builds as well, but it may include features that are
half-baked or under active development, but that are along enough that they
can be played with and tested.

We develop new features using feature branches. Feature branches have the
`feature/` prefix. Feature branches are under active development and may or
may not build. We don't actively build them as part of our continuous
integration process. When features are ready to be delivered, we use pull
requests to move the source code from the feature branch to the `develop`
branch.

If there is a new feature that you are interested in building on your own
and contributing, we recommend using a feature branch.

#### Submit a Pull Request

When you are ready to deliver your change, please create and submit a pull
request. A pull request will notify us of your changes and we will begin the
review process. We will do a thorough review of your contribution to ensure
that we understand the source code, that the source code is cleanly formatted,
and that the source code meets our quality guidelines. We may use the pull
request to ask you to make changes to the formatting of your source code, or
we may propose suggestions that may make your source code better. We ask that
you approach this process with an open mind.

Ultimately our goal is to accept and merge your contribution into our source
code. We want your changes and we will do our best to not turn away any
contributions as long as they make sense to the product. We're doing our best
to juggle the roles of software developer and product owner, and sometimes
that becomes a little tough to manage.

#### Git Commit Messages

We require all pull requests to have properly documented Git commit messages.
We like nicely formatted Git commit messages. It helps us to review the changes
that have gone into the product so that we can update the Changelog or just
review the project history. It also helps us if we are trying to find the
source of a bug to remember why a particular change happened.

Git commit messages sould have a title and a description. The title is the
first line of the commit message, followed by a blank line and then the
description text.

Please follow the following guidelines when formatting your Git commit
messages:

* Titles should be 50 characters or less
* Titles should use present tense ("create" instead of "created")
* Titles should use title case as much as possible
* Descriptions should have a single line between the title and the
  description text
* Lines containing description text for a commit should be no longer than
  72 characters so that log messages look cleanly formatted when viewing
  the repository history from the command line
* If the pull request corresponds to an open GitHub issue, the issue should
  be referenced from the pull request.

## Changes and Updates to the Contribution Guidelines

Naked Software, LLC, reserves the right to enhance and update the
Contribution Guidelines at any time in order to improve the contribution
experience. Please review this document before submitting enhancements to
ensure that all requirements and standards are met in contributions before
submitting them.
