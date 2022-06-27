# PUT zones/:zone_identifier/dns_records/:identifier
#--------CONFIG
zone="abcdefgh"
apiToken="abcdefgh"
DOMAIN="example.com"
dnsRecord="super-api."
EMAIL="example@gmail.com"

#Auto update in seconds
updateInterval=10
#--------DO NOT TOUCH!!!
while getopts zoneId:token:domain:dnsRecorod:email: flag
do
    case "${flag}" in
        zoneId) username=${OPTARG};;
        token) apiToken=${OPTARG};;
        zonedomainId) DOMAIN=${OPTARG};;
        dnsRecorod) dnsRecord=${OPTARG};;
        email) EMAIL=${OPTARG};;
    esac
done
lastIp=""

function reset(){
    ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

    if [ lastIp != ip ]; then
        #Get the dns record id
        dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records?type=A&name=${dnsRecord}${DOMAIN}" \
          -H "X-Auth-Email: ${EMAIL}" \
          -H "X-Auth-Key: ${apiToken}" \
          -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

        echo "Current global IpV4 is ${ip}"
        curl -X PUT "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records/${dnsrecordid}" \
             -H "X-Auth-Email: ${EMAIL}" \
             -H "X-Auth-Key: ${apiToken}" \
             -H "Content-Type: application/json" \
             --data "{\"type\":\"A\",\"name\":\"${dnsRecord}${DOMAIN}\",\"content\":\"${ip}\",\"ttl\":3600,\"proxied\":false}"

        $lastIp = $ip

    fi
    
}


while true; do reset; sleep $updateInterval; done