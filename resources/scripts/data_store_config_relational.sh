#!/bin/bash -x

# get the fully qualified domain name
# FQDN=$(hostname --fqdn)
USERNAME="admin"
PASSWORD="Esri3801"

# create the location to store the data with permissions
DATADIR="/var/spatial/relational"
if ! [ -d "$DATADIR" ]; then
     sudo mkdir -p "$DATADIR"
fi
sudo chown arcgis:arcgis "$DATADIR"

DSURL="https://localhost:2443/"
curl --retry 10 -sS -k "$DSURL" >> /tmp/curl_ds
if [ $? != 0 ]; then
   echo "Datastore is not running on $DSURL"
   #exit 1
else
   # set up a relational data store to support feature layer publishing
   # sudo su -c "/opt/arcgis/datastore/tools/configuredatastore.sh https://$FQDN:6443/arcgis $USERNAME $PASSWORD /var/spatial/relational --stores relational" arcgis
   sudo su -c "/opt/arcgis/datastore/tools/configuredatastore.sh https://localhost:6443/arcgis $USERNAME $PASSWORD /var/spatial/relational --stores relational" arcgis
fi
