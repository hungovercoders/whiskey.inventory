FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5231

ENV ASPNETCORE_URLS=http://+:5231

USER app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["WhiskeyAPI/WhiskeyAPI.csproj", "WhiskeyAPI/"]
RUN dotnet restore "WhiskeyAPI/WhiskeyAPI.csproj"
COPY . .
WORKDIR "/src/WhiskeyAPI"
RUN dotnet build "WhiskeyAPI.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "WhiskeyAPI.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WhiskeyAPI.dll"]
