<a href="https://github.com/camaraproject/{{repo_name}}/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/{{repo_name}}?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/{{repo_name}}?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/{{repo_name}}?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/{{repo_name}}?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/{{repo_name}}?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/{{repo_name}}/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/{{repo_name}}?style=plastic"></a>
<!-- Choose one of the following alternatives and then delete the task -->
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Sandbox API Repository"><img src="https://img.shields.io/badge/Sandbox%20API%20Repository-yellow?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Incubating API Repository"><img src="https://img.shields.io/badge/Incubating%20API%20Repository-green?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Graduated API Repository"><img src="https://img.shields.io/badge/Graduated%20API%20Repository-silver?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Working Group"><img src="https://img.shields.io/badge/Working%20Group-red?style=plastic"></a>

# {{repo_name}}

> [!NOTE]
> What is this repository about and how to use it:
>
> * For codeowners of existing CAMARA repository as a sample how a CAMARA repository should look like, e.g. to update legacy repositories. Have a look specifically on the [code of the README.md](https://github.com/camaraproject/Template_API_Repository/blob/main/README.md?plain=1) for different variants and copy relevant parts into your repository.
> * For CAMARA admins to create new (Sandbox) API repositories automated: Use the `setup-new-repo` workflow together with documentation in [templates/README.md](templates/README.md).
>
> The following is the template README for a new independent Sandbox API repository, other variants are within the commented code.

<!-- Alternative for new, independent Sandbox API Repositories -->
Sandbox API Repository to describe, develop, document, and test the {{repo_name}} Service API(s). The repository does not yet belong to a CAMARA Sub Project.

* API Repository [wiki page]({{repo_wiki_page}})

<!-- Alternative for Sandbox API Repositories within the context of an existing Sub Project -->

<!--
Sandbox API Repository to describe, develop, document, and test the {{repo_name}} Service API(s) within the Sub Project [{{subproject_name}}]({{subproject_wiki_page}})

* API Repository [wiki page]({{repo_wiki_page}})
-->

<!-- Alternative for Incubating API Repositories (always part of Sub Project, potentially created as part of the Incubation) --> 

<!--
Incubating API Repository to evolve and maintain the definitions and documentation of {{repo_name}} Service API(s) within the Sub Project [{{subproject_name}}]({{subproject_wiki_page}})

* API Repository [wiki page]({{repo_wiki_page}})
-->

<!-- for Graduation of an API Repository replace "Incubating" with "Graduated" and don't forget to exchange the badge :-) -->

<!-- Alternative if the repository will be used for a working group - in this case further points, e.g. the scope, of this template need to be adapted:

Repository for xxx of the {{subproject_name}} Working Group"

* Working Group [wiki home page]({{repo_wiki_page}}) 
!! Update with concrete link
-->

## Scope

* Service API(s) “{{repo_name}}” (see APIBacklog.md) 
* The API(s) provide(s) the API consumer with the ability to:  
  * §Short API scope description§ !! Add here a scope description according to the API proposal
* Describe, develop, document, and test the API(s)
* Started: §start date§
<!-- * Incubating stage since: {{incubation date}} --> 

## Release Information

The repository has no (pre)releases yet, work in progress is within the main branch.
<!-- Optional: an explicit listing of the latest (pre-)release with additional information, e.g. links to the API definitions -->
<!-- In addition use/uncomment one or multiple the following alternative options when becoming applicable -->
<!-- Pre-releases of this sub project are available in https://github.com/camaraproject/{{repo_name}}/releases -->
<!-- The latest public release is available here: https://github.com/camaraproject/{{repo_name}}/releases/latest -->
<!-- For changes see [CHANGELOG.md](https://github.com/camaraproject/{{repo_name}}/blob/main/CHANGELOG.md) -->

## Contributing

* Meetings are held virtually <!-- for new, independent Sandbox API repositories request a meeting link from the LF admin team or replace the information with the existing meeting information of the Sub Project -->

  * Schedule: !! tbd
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meetings/telcoapi) !! Update this link with your meeting registration/join link and delete the task
  * Minutes: Access [meeting minutes]({{repo_wiki_page}}) !! update this link to your minutes archive page using the "Share" link and delete the task
* Mailing List
  <!-- Note: the `mailinglistname` is either already existing (for API Repositories within a Sub Projects) or will be created by the CAMARA Admin Team. -->
  * Subscribe / Unsubscribe to the mailing list <https://lists.camaraproject.org/g/{{mailinglist_name}}>.
  * A message to the community of this Sub Project can be sent using <{{mailinglist_name}}@lists.camaraproject.org>.
