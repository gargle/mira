#!/bin/bash

set -x

thisscript=$0

# let us see what we have alredy

git config user.name "Automated"
git config user.email "github-actions@users.noreply.github.com"

# keep running for 30 minutes
endrun=$((SECONDS+1800))

while [ $SECONDS -lt $endrun ]; do
    # do nothing during the day
    date=$(date -u +%m%d)
    time=$(date -u +%H%M)
    riseandset=$(grep ^$date $thisscript)
    rise=${riseandset:5:4}
    set=${riseandset:10:4}
    if [ $time \> $rise ] && [ $time \< $set ]; then sleep 15; continue; fi
    while true ; do
        oldmd5sum=($(md5sum /tmp/previous.jpg))
        wget -O /tmp/west.jpg https://mira.be/webcam/west.jpg 2>>/tmp/wget.log
        timestamp=$(date +"%Y%m%d%H%M%S")
        md5sum=($(md5sum /tmp/west.jpg))
        if [[ ! $md5sum == $oldmd5sum ]]; then break; fi
        sleep 15
    done
    cp /tmp/west.jpg /tmp/previous.jpg
    git pull
    convert /tmp/west.jpg \
            \( +clone -crop 194x08+1086+0 +repage \) \
            -geometry +443+0 -composite /tmp/west.jpg
    convert /tmp/west.jpg \
            -crop 640x480+0+0 \
            mira-w-gray-$timestamp.jpg
    git add mira-w-gray-$timestamp.jpg
    git commit -m "Latest image: ${timestamp}"
    git push
done

exit

### sunrise and sunset in brussels in utc

0101 0706 1627
0102 0706 1628
0103 0706 1629
0104 0705 1630
0105 0705 1631
0106 0705 1632
0107 0705 1633
0108 0704 1634
0109 0704 1636
0110 0704 1637
0111 0703 1638
0112 0703 1639
0113 0702 1641
0114 0701 1642
0115 0701 1644
0116 0700 1645
0117 0659 1646
0118 0659 1648
0119 0658 1649
0120 0657 1651
0121 0656 1652
0122 0655 1654
0123 0654 1655
0124 0653 1657
0125 0652 1658
0126 0651 1700
0127 0650 1702
0128 0648 1703
0129 0647 1705
0130 0646 1706
0131 0645 1708
0201 0643 1710
0202 0642 1711
0203 0640 1713
0204 0639 1715
0205 0637 1716
0206 0636 1718
0207 0634 1720
0208 0633 1721
0209 0631 1723
0210 0630 1725
0211 0628 1726
0212 0626 1728
0213 0625 1730
0214 0623 1731
0215 0621 1733
0216 0619 1735
0217 0618 1736
0218 0616 1738
0219 0614 1740
0220 0612 1741
0221 0610 1743
0020 0608 1745
0223 0606 1746
0224 0604 1748
0225 0602 1750
0226 0600 1752
0227 0558 1753
0228 0556 1755
0229 0555 1756
0301 0554 1757
0302 0552 1758
0303 0550 1800
0304 0548 1802
0305 0546 1803
0306 0544 1805
0307 0542 1807
0308 0539 1808
0309 0537 1810
0310 0535 1812
0311 0533 1813
0312 0531 1815
0313 0529 1817
0314 0526 1818
0315 0524 1820
0316 0522 1822
0317 0520 1823
0318 0517 1825
0319 0515 1827
0320 0513 1828
0321 0511 1830
0322 0508 1832
0323 0506 1833
0324 0504 1835
0325 0502 1837
0326 0459 1838
0327 0457 1840
0328 0455 1842
0329 0452 1843
0330 0450 1845
0331 0448 1847
0401 0446 1848
0402 0443 1850
0403 0441 1852
0404 0439 1854
0405 0436 1855
0406 0434 1857
0407 0432 1859
0408 0430 1900
0409 0427 1902
0410 0425 1904
0411 0423 1906
0412 0421 1907
0413 0418 1909
0414 0416 1911
0415 0414 1913
0416 0412 1914
0417 0409 1916
0418 0407 1918
0419 0405 1920
0420 0403 1921
0421 0401 1923
0422 0358 1925
0423 0356 1927
0424 0354 1929
0425 0352 1930
0426 0350 1932
0427 0348 1934
0428 0346 1936
0429 0344 1937
0430 0342 1939
0501 0340 1941
0502 0338 1943
0503 0336 1945
0504 0334 1946
0505 0332 1948
0506 0330 1950
0507 0328 1952
0508 0326 1953
0509 0324 1955
0510 0322 1957
0511 0320 1959
0512 0319 2000
0513 0317 2002
0514 0315 2004
0515 0313 2006
0516 0312 2007
0517 0310 2009
0518 0309 2010
0519 0307 2012
0520 0306 2014
0521 0304 2015
0522 0303 2017
0523 0301 2018
0524 0300 2020
0525 0259 2021
0526 0257 2023
0527 0256 2024
0528 0255 2026
0529 0254 2027
0530 0253 2028
0531 0252 2030
0601 0251 2031
0602 0250 2032
0603 0249 2033
0604 0248 2034
0605 0247 2035
0606 0247 2037
0607 0246 2038
0608 0245 2038
0609 0245 2039
0610 0244 2040
0611 0244 2041
0612 0243 2042
0613 0243 2042
0614 0243 2043
0615 0243 2044
0616 0243 2044
0617 0242 2045
0618 0242 2045
0619 0243 2045
0620 0243 2046
0621 0243 2046
0622 0243 2046
0623 0243 2046
0624 0244 2046
0625 0244 2046
0626 0245 2046
0627 0245 2046
0628 0246 2046
0629 0246 2045
0630 0247 2045
0701 0248 2045
0702 0248 2044
0703 0249 2044
0704 0250 2043
0705 0251 2043
0706 0252 2042
0707 0253 2041
0708 0254 2040
0709 0255 2040
0710 0256 2039
0711 0258 2038
0712 0259 2037
0713 0300 2036
0714 0301 2035
0715 0303 2033
0716 0304 2032
0717 0306 2031
0718 0307 2030
0719 0308 2028
0720 0310 2027
0721 0311 2026
0722 0313 2024
0723 0314 2023
0724 0316 2021
0725 0318 2019
0726 0319 2018
0727 0321 2016
0728 0322 2015
0729 0324 2013
0730 0326 2011
0731 0327 2009
0801 0329 2008
0802 0331 2006
0803 0332 2004
0804 0334 2002
0805 0336 2000
0806 0337 1958
0807 0339 1956
0808 0341 1954
0809 0343 1952
0810 0344 1950
0811 0346 1948
0812 0348 1946
0813 0349 1944
0814 0351 1942
0815 0353 1940
0816 0355 1938
0817 0356 1936
0818 0358 1934
0819 0400 1931
0820 0401 1929
0821 0403 1927
0822 0405 1925
0823 0407 1923
0824 0408 1920
0825 0410 1918
0826 0412 1916
0827 0413 1914
0828 0415 1911
0829 0417 1909
0830 0418 1907
0831 0420 1905
0901 0422 1902
0902 0423 1900
0903 0425 1858
0904 0427 1855
0905 0428 1853
0906 0430 1851
0907 0432 1848
0908 0433 1846
0909 0435 1844
0910 0436 1842
0911 0438 1839
0912 0440 1837
0913 0441 1835
0914 0443 1832
0915 0444 1830
0916 0446 1828
0917 0448 1825
0918 0449 1823
0919 0451 1821
0920 0452 1818
0921 0454 1816
0922 0456 1814
0923 0457 1812
0924 0459 1809
0925 0500 1807
0926 0502 1805
0927 0504 1803
0928 0505 1800
0929 0507 1758
0930 0508 1756
1001 0510 1754
1002 0511 1751
1003 0513 1749
1004 0515 1747
1005 0516 1745
1006 0518 1743
1007 0519 1740
1008 0521 1738
1009 0523 1736
1010 0524 1734
1011 0526 1732
1012 0527 1730
1013 0529 1728
1014 0530 1726
1015 0532 1724
1016 0534 1722
1017 0535 1720
1018 0537 1718
1019 0538 1716
1020 0540 1714
1021 0542 1712
1022 0543 1710
1023 0545 1708
1024 0547 1706
1025 0548 1704
1026 0550 1703
1027 0551 1701
1028 0553 1659
1029 0555 1657
1030 0556 1656
1031 0558 1654
1101 0559 1652
1102 0601 1651
1103 0603 1649
1104 0604 1647
1105 0606 1646
1106 0607 1644
1107 0609 1643
1108 0611 1641
1109 0612 1640
1110 0614 1639
1111 0615 1637
1112 0617 1636
1113 0618 1635
1114 0620 1633
1115 0622 1632
1116 0623 1631
1117 0625 1630
1118 0626 1629
1119 0628 1628
1120 0629 1627
1121 0631 1626
1122 0632 1625
1123 0633 1624
1124 0635 1623
1125 0636 1622
1126 0638 1622
1127 0639 1621
1128 0640 1620
1129 0642 1620
1130 0643 1619
1201 0644 1618
1202 0646 1618
1203 0647 1618
1204 0648 1617
1205 0649 1617
1206 0650 1617
1207 0651 1616
1208 0652 1616
1209 0653 1616
1210 0654 1616
1211 0655 1616
1212 0656 1616
1213 0657 1616
1214 0658 1616
1215 0659 1616
1216 0700 1617
1217 0700 1617
1218 0701 1617
1219 0702 1618
1220 0702 1618
1221 0703 1618
1222 0703 1619
1223 0704 1620
1224 0704 1620
1225 0705 1621
1226 0705 1621
1227 0705 1622
1228 0705 1623
1229 0705 1624
1230 0706 1625
1231 0706 1626
