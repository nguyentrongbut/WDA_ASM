# --- STEP 1: Build stage ---
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy tất cả file project
COPY . .

# Restore package
RUN dotnet restore

# Build và publish
RUN dotnet publish -c Release -o /app/publish

# --- STEP 2: Runtime stage ---
# Runtime cũng dùng 9.0
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

# Copy app đã publish
COPY --from=build /app/publish .

# Port cho Render
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

# Entry point
ENTRYPOINT ["dotnet", "WDA_Practical.dll"]