using System.Text.Json;
using System.Reflection;


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

app.MapGet($"{basePath}/distilleries", (HttpContext context, int page = 1, int pageSize = 10, string? country = null, string? region = null) =>
{
    string json = File.ReadAllText("data/distilleries.json");

    Distillery[] allDistilleries = JsonSerializer.Deserialize<Distillery[]>(json);

    // Filter by country if provided
    if (!string.IsNullOrEmpty(country))
    {
        allDistilleries = allDistilleries.Where(d => d.Country.Equals(country, StringComparison.OrdinalIgnoreCase)).ToArray();
    }

    // Filter by region if provided
    if (!string.IsNullOrEmpty(region))
    {
        allDistilleries = allDistilleries.Where(d => d.Region.Equals(region, StringComparison.OrdinalIgnoreCase)).ToArray();
    }

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

app.MapGet($"{basePath}/distillery/{{attribute}}", (HttpContext context,  string attribute, string? country = null, string? region = null) =>
{
    string json = File.ReadAllText("data/distilleries.json");

    Distillery[] allDistilleries = JsonSerializer.Deserialize<Distillery[]>(json);

    // Filter by country if provided
    if (!string.IsNullOrEmpty(country))
    {
        allDistilleries = allDistilleries.Where(d => d.Country.Equals(country, StringComparison.OrdinalIgnoreCase)).ToArray();
    }

    // Filter by region if provided
    if (!string.IsNullOrEmpty(region))
    {
        allDistilleries = allDistilleries.Where(d => d.Region.Equals(region, StringComparison.OrdinalIgnoreCase)).ToArray();
    }

    var property = typeof(Distillery).GetProperty(attribute, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
    if (property == null)
    {
        return Results.NotFound();
    }

    var distilleryAttributes = allDistilleries
        .Select(d => property.GetValue(d)?.ToString())
        .Distinct()
        .ToList();

    return Results.Ok(distilleryAttributes);
})
.WithName("GetDistilleryAttribute")
.WithOpenApi()
.Produces<IEnumerable<String[]>>(200);


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

