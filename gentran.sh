#!/bin/bash
# set -x

cat file | while IFSA='' read -r serviceName || [[ -n "$serviceName" ]]; do

    webServiceLink=http://10.148.209.213:20040/wsdl?configName=$serviceName

    #curl -s -L `echo "${webServiceLink}" ` > result
    wget -O result -q `echo "${webServiceLink}" `

    if grep -q ${serviceName} result
    then 
        echo "${serviceName} ran successfully."  

    elif grep -q '404' result || grep -q '204' result || rep -q '500' result;
    then
        echo "Http, Sever error: ${serviceName}"
    else 
        echo "Data not found: ${serviceName}"
    fi

    rm -f result
done

echo "Exiting..."
exit 0
