# userauth

Userauth is an open source project that adds user authorisation and authentication capability (including login/password reset/user management/analytics screens) to a Wappler project.

## To add userauth to a Wappler project

### Run the following:

**Important:** The target Wappler project must be in a (local or remote) git repo

```
curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/install/install.sh | sh -s "<path-to-Wappler-project>"
```
Note: This has been tested on a Mac only - volunteers are welcome to offer up install steps/scripts for other platforms

### Next steps (to be done in Wappler):
1. Restart Wappler to pick up all changes
2. Create a Postgres Database connection called 'database'
3. Set a value for STEWARD_PASSWORD env variable in Workflows->Server Connect Settings->Environment
4. Open Site Manager->Pages->userauth/login and press the 'Open in Browser' button

Here's a video walkthrough of the set up process:  
https://www.youtube.com/watch?v=tFGXziLDf2I&ab_channel=ImpressDev

## To update the userauth modules:

### Run the following:

```
curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/install/update.sh | sh -s "<path-to-Wappler-project>"
```
Note: This has been tested on a Mac only - volunteers are welcome to offer up install steps/scripts for other platforms

### Next steps:
1. Add and commit the submodule updates to your git project
2. Enjoy the update

## To re-add submodules to a project that has been cloned using Wappler (submodules are not downloaded by default)

After creating a new project in Wappler based off a git repo, you might find that userauth login doesn't work as the userauth sub-modules are not downloaded as part of the git clone that Wappler does.

### Run the following:

```
cd "<path-to-Wappler-project>"
git submodule update --init
```

If you clone the project via the command line (and not add it as a new Git project in Wappler) then you can add the --recurse-submodules option as part of the clone:

```
git clone --recurse-submodules [repository-name]
```

Note: the --recurse-submodules option is currently untested but I added it as I thought it would be useful (source: https://phoenixnap.com/kb/git-pull-submodule)

## Wappler environment variable overrides

### End points
USERAUTH_LOGIN_API - endpoint that is called for login  
USERAUTH_REGISTER_API - endpoint that is called for registration  
USERAUTH_PASSWORD_CHANGE_API - endpoint that is called for a password change  
USERAUTH_PASSWORD_RESET_REQUEST_API - endpoint that is called for a password reset request  
USERAUTH_PASSWORD_RESET_API - endpoint that is called to reset a password  
USERAUTH_DATABASE_RESET_API - endpoint that is called for a database reset 

### Messages
USERAUTH_LOGIN_MESSAGE - message content shown on login page  
USERAUTH_REGISTER_MESSAGE - message content shown on registration page  
USERAUTH_PASSWORD_CHANGE_MESSAGE - message content shown on password change page  
USERAUTH_PASSWORD_RESET_REQUEST_MESSAGE - message content shown on password reset request page  
USERAUTH_PASSWORD_RESET_MESSAGE - message content shown on password reset page  

### Page redirects
USERAUTH_LOGIN_SUCCESS_PAGE - page/URL that is redirected to after a successful login  

### Recaptcha keys - recaptcha box is shown only when both are present
RECAPTCHA_SECRET_KEY - optional recaptcha secret key  
RECAPTCHA_SITE_KEY - optional recaptcha site key
  
### Email (SMTP) provider - email is sent only when all are present
EMAIL_SENDER - value in the From: field of the email  
EMAIL_SMTP_USER - username of SMTP account  
EMAIL_SMTP_PASSWORD - password of SMTP account  
EMAIL_SMTP_HOST - host of SMTP account  
EMAIL_SMTP_PORT - port of SMTP account

### Other
USERAUTH_DISABLE_REGISTRATIONS - turn off registrations: true/false(default)

## Updates
2023-11-25 - Clean up dependencies and improve mobile view
2023-11-23 - Add instructions regarding git projects using userauth which are opened as new Wappler projects
2023-04-27 - Add USERAUTH_DISABLE_REGISTRATIONS env var  
2023-04-18 - Small tidy up of includes (more work needs to be done here)  
2023-04-03 - Fix date format issue on admin console  
2023-04-01 - Add environment variable override documentation  
2023-04-01 - Add USERAUTH_LOGIN_SUCCESS_PAGE env var for optional redirect target after login  
2023-03-30 - Fix typo in conditional logic for USERAUTH_PASSWORD_CHANGE_API env var override  
2023-03-30 - Switch password change/reset to use Library modules  
2023-03-28 - Rename column used in user_permissions (was referencing id column and not userid)  
2023-03-28 - Fix broken link in password reset URL
