
```bash
func init --docker
```
```bash
func new --name DistilleryTrigger --template "CosmosDBTrigger"
```
```bash
dotnet add package CloudNative.CloudEvents
```
```bash
dotnet add package Newtonsoft.Json
```
```bash
docker run -e "CosmosConn=AccountEndpoint={insert}" distillery_event:latest
```