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

