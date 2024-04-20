using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

string[] origins = new string[] { Environment.GetEnvironmentVariable("CORS_ORIGINS") ?? string.Empty };

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        builder =>
        {
             builder.WithOrigins("*")
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

// builder.Services.AddCors(options =>
// {
//     options.AddPolicy("Development",
//         builder =>
//         {
//              builder.WithOrigins(localhost)
//                    .AllowAnyHeader()
//                    .AllowAnyMethod();
//         });
// });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    //app.UseCors("Development");
}

app.UseCors("AllowSpecificOrigins");

app.UseHttpsRedirection();

string environment = System.Environment.GetEnvironmentVariable("APP_ENVIRONMENT");
app.MapGet("/", () => $"Welcome to the whiskey API {environment} environment");

app.MapGet("/distilleries", () =>
{
       string json = File.ReadAllText("data/distilleries.json");

    // Deserialize the JSON into an array of Distillery objects
    Distillery[] distilleries = JsonSerializer.Deserialize<Distillery[]>(json);
    return distilleries;
})
.WithName("GetDistilleries")
.WithOpenApi();

app.MapGet("/health", () => "Healthy");

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

