#!/bin/bash

if [ -z "$1" ];
  then
    echo "Usage: ./update.sh <Wappler-project-directory>"
    exit 1
fi

if [ ! -d "$1" ];
then
    echo "The supplied Wappler project does not exist"
    exit 1
fi

if [[ ( -z "$2"  || ! "$2" = "--force" ) && ! -d "$1/.git" ]];
then
    echo "The supplied Wappler project needs to be a valid git project"
    exit 1
fi

if [ ! -d "$1/views" ];
then
    echo "The supplied parameter is not a valid Wappler project (missing views folder)"
    exit 1
fi

if [ ! -d "$1/views/layouts" ];
then
    echo "The supplied parameter is not a valid Wappler project (missing views/layous folder)"
    exit 1
fi

if [ ! -d "$1/app/api" ];
then
    echo "The supplied parameter is not a valid Wappler project (missing app/api folder)"
    exit 1
fi

if [ ! -f "$1/app/config/routes.json" ];
then
    echo "The supplied parameter is not a valid Wappler project (missing app/config/routes.json)"
    exit 1
fi

# Check the userauth submodule directories exit

if [ ! -d "$1/views/userauth" ];
then
    echo "The supplied parameter is not a valid userauth project (missing views/userauth)"
    exit 1
fi

if [ ! -d "$1/views/layouts/userauth" ];
then
    echo "The supplied parameter is not a valid userauth project (missing views/layouts/userauth)"
    exit 1
fi

if [ ! -d "$1/public/css/userauth" ];
then
    echo "The supplied parameter is not a valid userauth project (missing public/css/userauth)"
    exit 1
fi

if [ ! -d "$1/app/api/userauth" ];
then
    echo "The supplied parameter is not a valid userauth project (missing app/api/userauth)"
    exit 1
fi

if [ ! -d "$1/app/modules/lib/userauth" ];
then
    echo "The supplied parameter is not a valid userauth project (missing app/modules/lib/userauth)"
    exit 1
fi

# Do the upgrades

echo "Upgrading views/userauth"
cd "$1/views/userauth"
git pull origin main
cd ~-

echo "Upgrading views/layouts/userauth"
cd "$1/views/layouts/userauth"
git pull origin main
cd ~-

echo "Upgrading public/css/userauth"
cd "$1/public/css/userauth"
git pull origin main
cd ~-

echo "Upgrading app/api/userauth"
cd "$1/app/api/userauth"
git pull origin main
cd ~-

echo "Upgrading app/modules/lib/userauth"
cd "$1/app/modules/lib/userauth"
git pull origin main
cd ~-

echo
echo ">>> Upgrade complete - Next steps: <<<"
echo "1. Add and commit the submodule updates to your git project"
echo "2. Enjoy the update"
echo
