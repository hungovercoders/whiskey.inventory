using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Set the default root path
string basePath = "/api";
string[] origins = [Environment.GetEnvironmentVariable("CORS_ORIGINS") ?? string.Empty];

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        builder =>
        {
             builder.WithOrigins(origins)
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowSpecificOrigins");

app.UseHttpsRedirection();

string environment = System.Environment.GetEnvironmentVariable("APP_ENVIRONMENT");
app.MapGet($"{basePath}/", () => $"Welcome to the whiskey API {environment} environment");

app.MapGet($"{basePath}/distilleries", (HttpContext context, int page = 1, int pageSize = 10) =>
{
    string json = File.ReadAllText("data/distilleries.json");

    Distillery[] allDistilleries = JsonSerializer.Deserialize<Distillery[]>(json);

    int startIndex = (page - 1) * pageSize;

    Distillery[] paginatedDistilleries = allDistilleries
        .Skip(startIndex)
        .Take(pageSize)
        .ToArray();

    return Results.Ok(paginatedDistilleries);
})
.WithName("GetDistilleries")
.WithOpenApi()
.Produces<IEnumerable<Distillery>>(200);

app.MapGet($"{basePath}/health", () => "Healthy");

app.Run();

public class Distillery
{
    public string id { get; set; }
    public string Name { get; set; }
    public string Website { get; set; }
    public string Wikipedia { get; set; }
    public string Region { get; set; }
    public string Country { get; set; }
    public Location Location { get; set; }
}

public class Location
{
    public double Lat { get; set; }
    public double Lng { get; set; }
}

