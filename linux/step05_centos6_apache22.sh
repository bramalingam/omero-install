#!/bin/bash

#start-copy
cp setup_omero_apache22.sh ~omero
#end-copy

#start-install
yum -y install httpd mod_wsgi

# Install OMERO.web requirements
file=~omero/OMERO.server/share/web/requirements-py26-apache.txt
# introduce in 5.2.0
if [ -f $file ]; then
	pip install -r $file
fi

#start-setup-as-omero
# See setup_omero_apache.sh for the apache config file creation
su - omero -c "bash -eux setup_omero_apache22.sh"
#end-setup-as-omero

cp ~omero/OMERO.server/apache.conf.tmp /etc/httpd/conf.d/omero-web.conf

chkconfig httpd on
service httpd start