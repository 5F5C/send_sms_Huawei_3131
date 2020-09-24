#!/bin/bash
#Autor Sokov Valentin

RESPONSE=`curl -s -X GET http://192.168.8.1/api/webserver/SesTokInfo`
COOKIE=`echo "${RESPONSE}"| grep SesInfo| cut -b 58-185`
COOKIE="SessionID=${COOKIE}"
TOKEN=`echo "${RESPONSE}"| grep TokInfo| cut -b 205-236`
NUMBER=$1
SMS=`echo ${2} | sed 's/\ /\_/g'`

DATA="<?xmlversion='1.0'encoding='UTF-8'?><request><Index>-1</Index><Phones><Phone>$NUMBER</Phone></Phones><Sca></Sca><Content>$SMS</Content><L>

curl -v http://192.168.8.1/api/sms/send-sms \
 -H "Cookie:$COOKIE" -H "__RequestVerificationToken:$TOKEN" -H "Content-Type:application/x-www-form-urlencoded; charset=UTF-8" \
 --data $DATA
