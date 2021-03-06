#!/bin/bash

SSP_DIR="simplesamlphp"
CUSTOM_DIR="simplesamlphp.d"

WWW_USER_ID=${WWW_USER_ID:-82}

function traverse () {
    for file in `ls $1`
    do
	fileName="${1}/${file}"
        if [ ! -d ${fileName} ] ; then
           copyTo=`echo "${1}" | sed -r "s/^\/${CUSTOM_DIR}/\/${SSP_DIR}/g"`
           
           if [ ! -d ${copyTo} ] ; then
               mkdir -p ${copyTo}
           fi
          
           cp ${fileName} "${copyTo}/${file}"
        else
           traverse "${fileName}"
        fi
    done
}

traverse "/${CUSTOM_DIR}"

chown -R ${WWW_USER_ID}.${WWW_USER_ID} "/${SSP_DIR}"

/bin/bash
