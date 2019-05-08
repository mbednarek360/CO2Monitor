# global time var
date=$(date +'%H:%M:%S')

# get arguements
ip=$1
outp=$2

# loop
while true
do

    # download data
    data=""
    while [ "$data" = "" ]
    do 
        data=$(curl $ip)
    done

    # parse data
    celltemp=$(echo $data | jq .'celltemp')
    cellpres=$(echo $data | jq .'cellpres')
    co2=$(echo $data | jq .'co2')
    co2abs=$(echo $data | jq .'co2abs')
    h2o=$(echo $data | jq .'h2o')
    h2oabs=$(echo $data | jq .'h2oabs')
    h2odewpoint=$(echo $data | jq .'h2odewpoint')
    ivolt=$(echo $data | jq .'ivolt')
    co2raw=$(echo $data | jq .'raw'.'co2')
    co2ref=$(echo $data | jq .'raw'.'co2ref')
    h2oraw=$(echo $data | jq .'raw'.'h2o')
    h2oref=$(echo $data | jq .'raw'.'h2oref')

    # get time
    while [ "$date" = "$(date +'%H:%M:%S')" ]
    do
        echo > /dev/null
    done
    date=$(date +'%H:%M:%S')

    #output data in csv
    echo "$date, $celltemp, $cellpres, $co2, $co2abs,\
 $h2o, $h2oabs, $h2odewpoint, $ivolt, $co2raw, $co2ref,\
 $h2oraw, $h2oref" >> $outp

done