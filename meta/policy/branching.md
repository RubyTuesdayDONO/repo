# Branching Policy

This repository follows a Git branching policy modeled after
[Vincent Driessen][driessen]'s excellent essay
"[A Successful Git Branching Model][nvie]".

In our policy, commits are organized around a workflow
that separates mainline, hotfixes, releases, feature
development, and experimental sandboxes, freeing developers
to contribute organically without disturbing project stability.

[driessen]: http://nvie.com/about/
[nvie]: http://nvie.com/posts/a-successful-git-branching-model/

## Revision History

Branches in the structured workflow policy (i.e., anything
other than `box`) are considered "published", and must
never be force-pushed to rewrite previous history.
Of course, contributors may inevitably do this in local
clones of the repository; however it is discouraged
because the rewritten history is prohibited from
publication to shared repositories.

## Branches

While our branching policy is heavily influenced by Driessen's work,
we have renamed some branches for uniformity, and have consolidated
some related branches into hierarchies.

### `pub`: Mainline Stable Branch

The `pub` branch is analagous to the `master` branch
in most git repositories, and represents the stable
"mainline" state of the repository, in which all code
is expected to run without known errors or incomplete
features, and contains what an average user should consider
the latest accepted or "best" version of the project.
Versioned releases are tagged off of this branch,
and stable builds should only be composed from it.

### `fix`: Hotfixes and Bug Patches

The `fix' branch addresses problems discovered in the `pub` branch
after release, and should specifically target only such bugs.
Issues resolved in this branch may be merged back `pub`,
but only onto a new point release tag. The should also be merged
back into the `dev` branch to rectify errors there, but should not
be merged directly into release branches.

When multiple or distinguished issues are discovered in `pub`,
they should be tracked in separate sub-branches of `rel`
named for an identifier in an issue tracker using the format
`fix.${ISSUE}`, e.g. `fix.12345` or `fix.AUTH-1234`.
These sub-branches must be merged back into `fix`
before merging with `pub`, however they may be merged individually
into development branches for tracking purposes.

### `rel`: Releases

The `rel` branch represents the next stable release of the project,
incorporating features accepted in development before merging to `pub`.
`rel` always means the "next stable release" and should not contain
a mixture of anticipated releases. It may be divided into sub-branches
targeting different releases (in the format `rel.${VERSION}`, e.g. `rel.1.2.3`)
if development velocity produces uncertainty as to which version is appropriate
for the features intended for release (e.g. if a planned feature
is found to violate API version-stability promises) --
however these sub-branches must always be merged back into `rel`
before being merged to `pub` for a tagged release.

### `dev`: Feature Development

The `dev` branch represents the development of new features.
It "reflects a state with the latest delivered development changes
for the next release," and is analagous to an "integration branch"
against which automated builds are periodically executed.

Within this hierarchy, individual distinguished features
are developed in sub-branches (named `dev.${FEATURE}`,
e.g. `dev.2FA`). This differs slightly from Driessen's model
in nomenclature, but otherwise functions equivalently:
these sub-branches should branch off from `dev`,
and must merge back into it before incorporation
into a release (`rel.*`) branch.

### `box`: Experimentation Sandbox

The `box` branch (and `box.*` in its hierarchy) represent
experimental work not focused on any specific (or known)
features. Contributors may freely create and destroy
these branches without concern for the more structured
policy of other branches in the workflow. This aims
to encourage the good practice of "committing early
and often" without stifling creativity on dilemmas
around how to follow the structured policy.

To balance this (and to keep the structured branches
sanitized), `box` branches must not be merged
with any other branches in the structured policy.
They may, however, be cherry-picked into another branch
(typically `dev`).

Another distinction of the `box` hierarchy is that
the prohibition against history revision does not apply.
The history of `box` branches may be thrashed about
without any prejudice to the policy for normal
"structured" branches.

Lastly, to avoid collision between identically-named
branches in the `box` hierarchy, the project should
devise a namespace strategy that isolates contributors
from one another -- such as naming sub-branches
by contributor name. For example, Jane Doe's sandbox
branches might be named in the pattern `box.jdoe.*`.
