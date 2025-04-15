# 📘 Sandbox API Repository Creation Automation for CAMARA

This document describes how to use the GitHub Action in the `Template_API_Repository` to automate the setup of new API repositories within the CAMARA GitHub organization or within a personal namespace.

---

## 🚀 Purpose

To automate the initial setup of a new repository, including:

- Creating a new repository from the template
- Setting metadata and repository settings
- Creating teams and assigning permissions (if in an organization)
- Adding CODEOWNERS based on a template
- Posting issues with initial checklists
- Cleaning up setup artifacts (workflow + templates) - not yet implemented

---

## ⚙️ How to Use

1. Go to the **Actions** tab of your fork or the template repo
2. Trigger the **"Setup New Repository"** workflow manually using **workflow\_dispatch**
3. Fill in the following inputs:

### 🔢 Inputs

- `repo_name`: Name of the new repository to create
- `subproject_name`: Optional subproject/working group name
- `repo_wiki_page`: Link to the repository wiki
- `subproject_wiki_page`: Optional link to the subproject wiki
- `mailinglist_name`: Mailing list for project discussion
- `initial_codeowners`: Space-separated GitHub usernames with `@` (e.g., `@alice @bob`)

---

## 📄 What It Does

### ✅ Repository

- Creates a new public repository from the template
- Sets description, homepage (to wiki), and topic `sandbox-api-repository`
- Enables issues and discussions, disables wiki

### ✅ Teams

- Creates `repo_name_maintainers` and `repo_name_codeowners` under parent teams (if applicable)
- Adds each codeowner to the CODEOWNERS team (if user exists)

### ✅ Files

- Replaces placeholders in `README.md`
- Generates CODEOWNERS from `templates/CODEOWNERS`
- Posts 2 issues using templates in `templates/issues/*.md`
- Adds a comment to the first issue confirming setup success

### ✅ Rulesets

- Sync rulesets from template repository

### ✅ Cleanup (currently not implemented)

- Deletes the workflow file itself from the new repo
- Deletes all files inside the `templates/` folder

---

## 🔐 Requirements

### 🔑 GitHub Personal Access Token (PAT)

- Stored as repository or environment secret: `GH_REPO_CREATE_TOKEN`
- Must have scopes:
  - `repo`
  - `admin:org` (if using teams)

### 🛡 Environment Restrictions

- The workflow is restricted to run in a GitHub Environment: `repo-setup`
- That environment must be configured in **Settings → Environments**
- Add the `@camaraproject/admins` team as required reviewers to control access
- Store the `GH_REPO_CREATE_TOKEN` secret inside this environment

---

## 📦 Required Template Files

The following must exist in the `Template_API_Repository`:

```
templates/CODEOWNERS
templates/issues/initial-admin.md
templates/issues/initial-codeowners.md
```

---

## 🧪 Testing Tips

- Use a test repo name like `test-repo-$(date +%s)` to avoid naming collisions
- Run in a personal account if you want to skip org/team features
- Check your repo afterwards for:
  - Metadata
  - CODEOWNERS file
  - Issue templates and comment
  - Removed setup files

---

For questions, open an issue in the template repository or contact a CAMARA admin.
