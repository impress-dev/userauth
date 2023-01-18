#!/bin/bash

if [ -z "$1" ]
  then
    echo "Usage: ./install.sh <Wappler-project-directory>"
    exit 1
fi

if [ ! -d "$1" ]
then
    echo "The supplied Wappler project does not exist"
    exit 1
fi

if [ ! -d "$1/.git" ]
then
    echo "The supplied Wappler project needs to be a valid git project"
    exit 1
fi

if [ ! -d "$1/views" ]
then
    echo "The supplied parameter is not a valid Wappler project (missing views folder)"
    exit 1
fi

if [ ! -d "$1/views/layouts" ]
then
    echo "The supplied parameter is not a valid Wappler project (missing views/layous folder)"
    exit 1
fi

if [ ! -d "$1/app/api" ]
then
    echo "The supplied parameter is not a valid Wappler project (missing app/api folder)"
    exit 1
fi

if [ ! -f "$1/app/config/routes.json" ]
then
    echo "The supplied parameter is not a valid Wappler project (missing app/config/routes.json)"
    exit 1
fi

cd "$1"

if [ -d "$1/views/userauth-web" ]
then
    echo "INFO: views/userauth-web already exists so not re-adding as sub-module"
else
    echo "INFO: Adding userauth-web"
    git submodule add https://github.com/impress-dev/userauth-web.git "$1/views/userauth-web"
fi

if [ -d "$1/views/layouts/userauth-web" ]
then
    echo "INFO: views/layouts/userauth-web already exists so not re-adding as sub-module"
else
    echo "INFO: Adding userauth-layouts"
    git submodule add https://github.com/impress-dev/userauth-layouts.git "$1/views/layouts/userauth-web"
fi

if [ -d "$1/public/css/userauth-web" ]
then
    echo "INFO: public/css/userauth-web already exists so not re-adding as sub-module"
else
    echo "INFO: Adding userauth-css"
    git submodule add https://github.com/impress-dev/userauth-css.git "$1/public/css/userauth-web"
fi

if [ -d "$1/app/api/userauth-api" ]
then
    echo "INFO: app/api/userauth-api already exists so not re-adding as sub-module"
else
    echo "INFO: Adding userauth-api"
    git submodule add https://github.com/impress-dev/userauth-api.git "$1/app/api/userauth-api"
fi

if [ ! -d "$1/app/modules" ]
then
    mkdir "$1/app/modules"
fi

if [ ! -d "$1/app/modules/lib" ]
then
    mkdir "$1/app/modules/lib"
fi

if [ -d "$1/app/modules/lib/userauth-lib" ]
then
    echo "INFO: app/modules/lib/userauth-lib already exists so not re-adding as sub-module"
else
    echo "INFO: Adding userauth-lib"
    git submodule add https://github.com/impress-dev/userauth-lib.git "$1/app/modules/lib/userauth-lib"
fi

if grep -Fq "userauth-web" "$1/app/config/routes.json"
then
    echo "INFO: userauth-web already exists in routes.json so not re-adding routes"
else
    head -n 2 "$1/app/config/routes.json" > "$1/app/config/routes.json.new"
    curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/routes.json.snippet >> "$1/app/config/routes.json.new"
    tail -n +3 "$1/app/config/routes.json" >> "$1/app/config/routes.json.new"
    ROUTES_BACKUP="$1/app/config/routes.json.$(date +"%Y%m%d-%H%M%S")"
    mv "$1/app/config/routes.json" "$ROUTES_BACKUP"
    echo "INFO: routes.json has been backed up to: $ROUTES_BACKUP"
    mv "$1/app/config/routes.json.new" "$1/app/config/routes.json"
fi

if [ ! -f "$1/app/modules/global.json" ]
then
    echo "INFO: Adding global.json"
    curl -s https://raw.githubusercontent.com/impress-dev/userauth/main/global.json --output "$1/app/modules/global.json"
elif grep -Fq "STEWARD_PASSWORD" "$1/app/modules/global.json"
then
    echo "INFO: global.json already contains STEWARD_PASSWORD so not re-adding ENV variables"
else
    echo "WARNING: global.json already exists and so required ENV variables will need to be added manually"
fi

if [ -f "$1/app/modules/Mailer/mail.json" ]
then
    echo "INFO: app/modules/Mailer/mail.json already exists so not re-adding"
else
    curl --create-dirs --silent https://raw.githubusercontent.com/impress-dev/userauth/main/mail.json --output "$1/app/modules/Mailer/mail.json"
fi

if [ -f "$1/.wappler/targets/Development/app/modules/Mailer/mail.json" ]
then
    echo "INFO: .wappler/targets/Development/app/modules/Mailer/mail.json already exists so not re-adding"
else
    curl --create-dirs --silent https://raw.githubusercontent.com/impress-dev/userauth/main/mail.json --output "$1/.wappler/targets/Development/app/modules/Mailer/mail.json"
fi

if [ -f "$1/app/modules/SecurityProviders/security.json" ]
then
    echo "INFO: app/modules/SecurityProviders/security.json already exists so not re-adding"
else
    curl --create-dirs --silent https://raw.githubusercontent.com/impress-dev/userauth/main/security.json --output "$1/app/modules/SecurityProviders/security.json"
fi

if [ -f "$1/.wappler/targets/Development/app/modules/SecurityProviders/security.json" ]
then
    echo "INFO: .wappler/targets/Development/app/modules/SecurityProviders/security.json already exists so not re-adding"
else
    curl --create-dirs --silent https://raw.githubusercontent.com/impress-dev/userauth/main/security.json --output "$1/.wappler/targets/Development/app/modules/SecurityProviders/security.json"
fi

# For now I'm downloading all known Wappler dependencies (as Impress does not currently selectively include them)
# This will be cleaned up in a later release

if [ ! -f "$1/public/dmxAppConnect/dmxAppConnect.js" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxAppConnect.js --output "$1/public/dmxAppConnect/dmxAppConnect.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxAnimateCSS" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxAnimateCSS/animate.min.css --output "$1/public/dmxAppConnect/dmxAnimateCSS/animate.min.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxAnimateCSS/dmxAnimateCSS.js --output "$1/public/dmxAppConnect/dmxAnimateCSS/dmxAnimateCSS.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxBootbox5" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxBootbox5/bootstrap-modbox.min.js --output "$1/public/dmxAppConnect/dmxBootbox5/bootstrap-modbox.min.js"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxBootbox5/dmxBootbox5.js --output "$1/public/dmxAppConnect/dmxBootbox5/dmxBootbox5.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxBootstrap5Modal" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxBootstrap5Modal/dmxBootstrap5Modal.js --output "$1/public/dmxAppConnect/dmxBootstrap5Modal/dmxBootstrap5Modal.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxBrowser" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxBrowser/dmxBrowser.js --output "$1/public/dmxAppConnect/dmxBrowser/dmxBrowser.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxCharts" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxCharts/Chart.min.js --output "$1/public/dmxAppConnect/dmxCharts/Chart.min.js"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxCharts/dmxCharts.js --output "$1/public/dmxAppConnect/dmxCharts/dmxCharts.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxDatePicker" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDatePicker/daterangepicker.min.css --output "$1/public/dmxAppConnect/dmxDatePicker/daterangepicker.min.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDatePicker/daterangepicker.min.js --output "$1/public/dmxAppConnect/dmxDatePicker/daterangepicker.min.js"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDatePicker/dmxDatePicker.css --output "$1/public/dmxAppConnect/dmxDatePicker/dmxDatePicker.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDatePicker/dmxDatePicker.js --output "$1/public/dmxAppConnect/dmxDatePicker/dmxDatePicker.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxDownload" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDownload/dmxDownload.js --output "$1/public/dmxAppConnect/dmxDownload/dmxDownload.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxDropzone" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDropzone/dmxDropzone.css --output "$1/public/dmxAppConnect/dmxDropzone/dmxDropzone.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxDropzone/dmxDropzone.js --output "$1/public/dmxAppConnect/dmxDropzone/dmxDropzone.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxFormatter" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxFormatter/dmxFormatter.js --output "$1/public/dmxAppConnect/dmxFormatter/dmxFormatter.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxMediumEditor" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxMediumEditor/dmxMediumEditor.css --output "$1/public/dmxAppConnect/dmxMediumEditor/dmxMediumEditor.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxMediumEditor/medium-editor.js --output "$1/public/dmxAppConnect/dmxMediumEditor/medium-editor.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxNotifications" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxNotifications/dmxNotifications.css --output "$1/public/dmxAppConnect/dmxNotifications/dmxNotifications.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxNotifications/dmxNotifications.js --output "$1/public/dmxAppConnect/dmxNotifications/dmxNotifications.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxRouting" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxRouting/dmxRouting.js --output "$1/public/dmxAppConnect/dmxRouting/dmxRouting.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxScheduler" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxScheduler/dmxScheduler.js --output "$1/public/dmxAppConnect/dmxScheduler/dmxScheduler.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxStateManagement" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxStateManagement/dmxStateManagement.js --output "$1/public/dmxAppConnect/dmxStateManagement/dmxStateManagement.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxValidator" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxValidator/dmxValidator.css --output "$1/public/dmxAppConnect/dmxValidator/dmxValidator.css"
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxValidator/dmxValidator.js --output "$1/public/dmxAppConnect/dmxValidator/dmxValidator.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxStateManagement" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxStateManagement/dmxStateManagement.js --output "$1/public/dmxAppConnect/dmxStateManagement/dmxStateManagement.js"
fi

if [ ! -d "$1/public/dmxAppConnect/dmxSockets" ]
then
    curl --create-dirs --silent https://impress.dev/dmxAppConnect/dmxSockets/dmxSockets.js --output "$1/public/dmxAppConnect/dmxSockets/dmxSockets.js"
fi

if [ ! -d "$1/public/socket.io" ]
then
    curl --create-dirs --silent https://impress.dev/socket.io/socket.io.js --output "$1/public/socket.io/socket.io.js"
fi

if [ ! -d "$1/public/bootstrap/5" ]
then
    curl --create-dirs --silent https://impress.dev/bootstrap/5/css/bootstrap.min.css --output "$1/public/bootstrap/5/css/bootstrap.min.css"
    curl --create-dirs --silent https://impress.dev/bootstrap/5/js/bootstrap.bundle.min.js --output "$1/public/bootstrap/5/js/bootstrap.bundle.min.js"
fi

if [ ! -d "$1/public/socket.io" ]
then
    curl --create-dirs --silent https://impress.dev/socket.io/socket.io.js --output "$1/public/socket.io/socket.io.js"
fi

if [ ! -d "$1/public/js/moment.js/2" ]
then
    curl --create-dirs --silent https://impress.dev/js/moment.js/2/moment.min.js --output "$1/public/js/moment.js/2/moment.min.js"
fi

if [ ! -f "$1/public/js/jquery-3.5.1.slim.min.js" ]
then
    curl --create-dirs --silent https://impress.dev/js/jquery-3.5.1.slim.min.js --output "$1/public/js/jquery-3.5.1.slim.min.js"
fi

cd -
