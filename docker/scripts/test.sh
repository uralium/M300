# !/bin/sh

sites=( https://nc.network.local https://pma.network.local https://wp.network.local/wp-admin/install.php )

for s in "${sites[@]}"
do
    status_code=$(curl --write-out %{http_code} --silent --head --output /dev/null -k $s)

    if [[ "$status_code" -ne 200 ]] ; then
        echo Site $s exits with code $status_code
        exit 1
    else
        exit 0
    fi
done