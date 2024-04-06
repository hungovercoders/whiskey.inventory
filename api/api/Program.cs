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
            builder.WithOrigins("http://localhost:8080") // Corrected URL
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

app.MapGet("/distilleries", () =>
{
    var distilleries = new Distillery[]
       {
            new Distillery
            {
                Name = "Achill Island Distillery",
                Website = "www.irishamericanwhiskeys.com",
                Region = "County Mayo",
                Country = "Ireland",
                Location = new Location { Lat = 53.9631, Lng = -10.0069 }
            },
            new Distillery
            {
                Name = "Bushmills Distillery",
                Website = "www.bushmills.com",
                Region = "County Antrim",
                Country = "Northern Ireland",
                Location = new Location { Lat = 55.2048, Lng = -6.5236 }
            },
            new Distillery
            {
                Name = "Jameson Distillery",
                Website = "www.jamesonwhiskey.com",
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

