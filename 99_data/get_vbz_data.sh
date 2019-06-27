
year=2018


# Call the HTML code and extract the links to the resources
curl https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd_${year} | grep -i "schema:url" > data_urls_raw.txt
# results in 
#             "schema:url": "https://data.stadt-zuerich.ch/group/mobilitat"
#             "schema:url": "https://data.stadt-zuerich.ch/dataset/303ece0e-cfdf-40da-ba91-e9[...]
#             "schema:url": "https://data.stadt-zuerich.ch/dataset/303ece0e-cfdf-40da-ba91-e9[...]



# Some non-CSV files got filtered, so filter out all non-CSV files from the list
grep -i ".csv" data_urls_raw.txt > data_urls.txt
# results in
# "schema:url": "https://data.stadt-zuerich.ch/dataset/303ece0e-c[...]



# Discard the what is before the first three ':' colons
cut -d : -f 4 data_urls.txt > data_urls_path.txt
# results in
# //data.stadt-zuerich.ch/dataset/303ece0e-cfdf-40da-ba91[...]



# Prepend 'http:' again
sed -ie 's/^/https:/g' data_urls_path.txt
# '-ie': saves the change to the file in place (so no new file needed)
# results in
# http://data.stadt-zuerich.ch/dataset/303ece0e-cfdf-40da-ba91-e997851be187/resour[...]"
# NOTE the trailing quotation mark '"'



# Discard trailing '"' quotation marks
sed -ie 's/"//g' data_urls_path.txt
# results in
# http://data.stadt-zuerich.ch/dataset/303ece0e-cfdf-40da-b[...]fahrzeiten_soll_ist_20180729_20180804.csv

