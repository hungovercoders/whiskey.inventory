docker pull mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator

docker run -p 8081:8081 -p 10251:10251 -p 10252:10252 -p 10253:10253 -p 10254:10254 -m 3g --cpus=2.0 --name=cosmosdb-emulator -e AZURE_COSMOS_EMULATOR_PARTITION_COUNT=2 -e AZURE_COSMOS_EMULATOR_ENABLE_DATA_PERSISTENCE=true -d mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator

