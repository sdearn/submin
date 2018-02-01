#!/bin/bash

set -x

# use command submin
hostname="${SUBMIN_HOSTNAME:-submin.local}"
external_port="${SUBMIN_EXTERNAL_PORT:-80}"
data_dir="${SUBMIN_DATA_DIR:-/var/lib/submin}"
svn_repo="${SUBMIN_SVN_DIR:-/var/lib/svn}"
admin_mail="${SUBMIN_ADMIN_MAIL:-root@submin.local}"

if [ ! -e ${data_dir} ]; then
    echo -e "svn\n${svn_repo}\n${hostname}:${external_port}\n\n\n" \
        | submin2-admin ${data_dir} initenv ${admin_mail} >/dev/null


    submin2-admin ${data_dir} apacheconf create all >/dev/null 2>&1 || true

    ln -s ${data_dir}/conf/apache-webui-cgi.conf /etc/httpd/conf.d/
    ln -s ${data_dir}/conf/apache-svn.conf /etc/httpd/conf.d/

    chmod 755  ${data_dir}/../
    chown apache:apache -R ${data_dir}

    # disable git
    submin2-admin ${data_dir} config set vcs_plugins svn || true

    key=`echo "SELECT key FROM password_reset;" | sqlite3 ${data_dir}/conf/submin.db`
    echo "access http://${hostname}:${external_port}/submin/password/admin/${key} to reset password"

else
    echo "Submin is already configured in ${data_dir}/conf"
fi
service httpd restart

#tail -f /etc/httpd/logs/access.log /etc/httpd/logs/error.log
