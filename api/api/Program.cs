var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        builder =>
        {
             builder.WithOrigins("http://localhost:8080", "https://dev-whiskey-web-eun-hngc.salmonsea-c65b336a.northeurope.azurecontainerapps.io", "whiskey.hungovercoders.com")
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowSpecificOrigins");

app.UseHttpsRedirection();

string environment = System.Environment.GetEnvironmentVariable("APP_ENVIRONMENT");
app.MapGet("/", () => $"Welcome to the whiskey API {environment} environment");

app.MapGet("/distilleries", () =>
{
    var distilleries = new Distillery[]
       {
            new Distillery
            {
                Name = "Achill Island Distillery",
                Website = "https://www.irishamericanwhiskeys.com",
                Region = "County Mayo",
                Country = "Ireland",
                Location = new Location { Lat = 53.9631, Lng = -10.0069 }
            },
            new Distillery
            {
                Name = "Bushmills Distillery",
                Website = "https://www.bushmills.com",
                Region = "County Antrim",
                Country = "Northern Ireland",
                Location = new Location { Lat = 55.2048, Lng = -6.5236 }
            },
            new Distillery
            {
                Name = "Jameson Distillery",
                Website = "https://www.jamesonwhiskey.com",
                Region = "County Dublin",
                Country = "Ireland",
                Location = new Location { Lat = 53.3419, Lng = -6.2865 }
            }
       };
    return distilleries;
})
.WithName("GetDistilleries")
.WithOpenApi();

app.MapGet("/health", () => "Healthy");

app.Run();

public class Distillery
{
    public string Name { get; set; }
    public string Website { get; set; }
    public string Region { get; set; }
    public string Country { get; set; }
    public Location Location { get; set; }
}

public class Location
{
    public double Lat { get; set; }
    public double Lng { get; set; }
}

