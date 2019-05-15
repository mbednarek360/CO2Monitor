# global time var
old=""
outp="$(date +'%m-%d-%Y').csv"

# get arguements
ip=$1
dir=$2

# loop
while true
do

    # refresh output directory
    if [ "$outp" != "$(date +'%m-%d-%Y').csv" ]
    then

        # prepeare data file
        outp="$(date +'%m-%d-%Y').csv"
        rm $dir/$outp
        touch $dir/$outp
        echo "time, celltemp, cellpres, co2, co2abs,\
 h2o, h2oabs, h2odewpoint, ivolt, co2raw, co2ref,\
 h2oraw, h2oref" >> $dir/$outp
    fi

    # download data
    data=""
    while [ "$(echo "$data" | wc -l)" != "17" ]
    do 
        data=$(curl -s $ip)  
    done

    {
        # parse data
        time=$(echo $data | jq .'time')
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
    } || {
        echo "Malformed Packet: Skipping..."
        continue
    }

    if [ "$time" ==  "$old" ]
    then
        continue
    else
        old="$time" 
    fi

    #output data in csv
    echo "$time, $celltemp, $cellpres, $co2, $co2abs,\
 $h2o, $h2oabs, $h2odewpoint, $ivolt, $co2raw, $co2ref,\
 $h2oraw, $h2oref" >> $dir/$outp 
 
 # stdout logs
    echo "Wrote data: $time"


done
