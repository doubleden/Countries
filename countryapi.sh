MODULE="Modules/restcountries/Sources/restcountries/"

openapi-generator generate -i "restcountries-api.yaml" -g swift5 -o "restcountries" --additional-properties=useJsonEncodable=false
rm -r $MODULE""*
cp -R "restcountries/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "restcountries"


