using System;
using System.Text;
using CloudNative.CloudEvents;
using CloudNative.CloudEvents.NewtonsoftJson;
using Newtonsoft.Json;

class Program
{
    static void Main(string[] args)
    {
        // Create a CloudEvent
        var cloudEvent = new CloudEvent
        {
            Id = Guid.NewGuid().ToString(),
            Type = "com.example.sample",
            Source = new Uri("https://example.com"),
            DataContentType = "application/json",
            Time = DateTime.UtcNow,
            Data = new { Message = "Hello, CloudEvents!" }
        };

        // Serialize the CloudEvent to JSON
        var formatter = new JsonEventFormatter();
        var json = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(cloudEvent, formatter.Settings));

        // Display the serialized CloudEvent
        Console.WriteLine(Encoding.UTF8.GetString(json));
    }
}
