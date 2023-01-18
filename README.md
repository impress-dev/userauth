# userauth

**Important:** The Wappler project must be in a git repo (local or remote)

To install all the necessary files used by userauth, run the following commands:

```
curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/install.sh | sh -s "<path to Wappler project>"
cd "<path to Wappler project>"
git submodule update --init --recursive
```

**Important:** Restart Wappler after the above steps have been completed
