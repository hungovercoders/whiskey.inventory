using System.Text.Json.Serialization;
using System.ComponentModel.DataAnnotations;

namespace WhiskeyAPI.Models
{
     /// <summary>
    /// Represents a distillery.
    /// </summary>
    public class Distillery
    {
        /// <summary>
        /// This is the name of the distillery
        /// </summary>
        [JsonPropertyName("name")]
        public string Name { get; set; } 

        /// <summary>
        /// This is a link to the website of the distillery
        /// </summary>
        [JsonPropertyName("website")]
        public string? Website { get; set; }

        /// <summary>
        /// This is the country that the distillery is found in 
        /// </summary>
        [JsonPropertyName("country")]
        public string? Country { get; set; }

        /// <summary>
        /// This is the region of the whiskey distillery
        /// </summary>
        [JsonPropertyName("region")]
        public string? Region { get; set; }

        /// <summary>
        /// These are the geocordinate location of the whiskey distillery
        /// </summary>
        [JsonPropertyName("location")]
        public GeoCoordinates? Location { get; set; }
    }
}

public class GeoCoordinates
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }

    public GeoCoordinates(double latitude, double longitude)
    {
        Latitude = latitude;
        Longitude = longitude;
    }
}