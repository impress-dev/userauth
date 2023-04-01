# userauth

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


## To update the userauth modules:

### Run the following:

```
curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/install/update.sh | sh -s "<path-to-Wappler-project>"
```
Note: This has been tested on a Mac only - volunteers are welcome to offer up install steps/scripts for other platforms

### Next steps:
1. Add and commit the submodule updates to your git project
2. Enjoy the update

## Wappler environment variable overrides

### End points
USERAUTH_DATABASE_RESET_API - endpoint that is called for a database reset
USERAUTH_LOGIN_API - endpoint that is called for login
USERAUTH_REGISTER_API - endpoint that is called for registration
USERAUTH_PASSWORD_CHANGE_API - endpoint that is called for a password change
USERAUTH_PASSWORD_RESET_REQUEST_API - endpoint that is called for a password reset request
USERAUTH_PASSWORD_RESET_API - endpoint that is called to reset a password

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

## Updates
2023-04-01 - Insert environment variable override documentation
2023-04-01 - Add USERAUTH_LOGIN_SUCCESS_PAGE env var for optional redirect target after login  
2023-03-30 - Fix typo in conditional logic for USERAUTH_PASSWORD_CHANGE_API env var override  
2023-03-30 - Switch password change/reset to use Library modules  
2023-03-28 - Rename column used in user_permissions (was referencing id column and not userid)  
2023-03-28 - Fix broken link in password reset URL
