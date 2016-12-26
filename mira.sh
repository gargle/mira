#!/bin/bash



# we calculate sunrise and sunset and see if we have to take a picture

while true; do

    today=$(date "+%Y-%m-%d")

    if [[ $sundate != $today ]]
    then
        set $(curl -s http://www.sunrise-and-sunset.com/en/sun/belgium/brussels \
            | grep "datetime=\"${today}T" \
            | sed -e  "s/^\s*<time datetime=\"${today}T//;s/\">.*$//")
        sunrise=$1
        sunset=$2
        sundate=$today
    fi

    now=$(date "+%H:%M:%S")

    if [[ ! $now < $sunrise && ! $now > $sunset ]]
    then
        exit 255 # daylight, we don't bother
    fi

    # if we get to this point we can take a picture, which is refreshed on the mira website
    # every 30 seconds. We check for modifications by comparing the exif data

    while true; do

        rm /tmp/mira-current.jpg 2>/dev/null
        wget -O /tmp/mira-current.jpg \
             http://mira.telenet.be/mira_mobotix/current2.jpg 2>/dev/null

        # we fetch the exit data
        exifdate=$(identify -verbose -format '%[exif:DateTimeDigitized]' /tmp/mira-current.jpg)

        if [[ ! $exifdate == $oldexifdate ]]; then break; fi

        sleep 15

    done

    # here we cut the left part out, make it smaller, and annotate the picture

    convert /tmp/mira-current.jpg \
            -crop 1920x1024+0+0 \
            -repage 1920x1024 \
            -fill white \
            -pointsize 24 \
            -gravity SouthEast -annotate 0 "$exifdate" \
            /tmp/mira-${exifdate//[ :]/}.jpg

    oldexifdate=$exifdate

    echo "MIME-Version: 1.0 (mime-construct 1.9)\n" > /tmp/emlbody
    echo "Content-Type: image/jpeg\n" >> /tmp/emlbody
    echo "Content-Transfer-Encoding: base64" >> /tmp/emlbody
    cat /tmp/mira-${exifdate//[ :]/}.jpg | base64 >> /tmp/emlbody
    curl -n --user 'fons.de.la.spons@gmail.com:jb120673' \
	 --ssl-reqd --mail-from "fons.de.la.spons@gmail.com" \
	 --mail-rcpt "fons.de.la.spons@gmail.com" \
	 --url 'smtps://smtp.gmail.com:465' --upload-file /tmp/emlbody \
	 --insecure

done
