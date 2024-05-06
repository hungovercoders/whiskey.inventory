using System;
using System.Collections.Generic;
using System.Net.Mime;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using CloudNative.CloudEvents;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace event_handler
{
    public static class DistilleryTrigger
    {
        [FunctionName("DistilleryTrigger")]
        public static void Run([CosmosDBTrigger(
            databaseName: "whiskey",
            containerName: "distilleries",
            Connection = "CosmosConn",
            LeaseContainerName = "leases",
            CreateLeaseContainerIfNotExists = true)]IReadOnlyList<Distillery> input,
            ILogger log)
        {
            if (input != null && input.Count > 0)
            {
                log.LogInformation("Documents modified " + input.Count);
                log.LogInformation("First document Id " + input[0].id);
                log.LogInformation("First document Name " + input[0].Name);

                // Serialize the CloudEvent data
                var cloudEventJson = JsonConvert.SerializeObject(input, new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver(),
                    TypeNameHandling = TypeNameHandling.Auto
                });


             var cloudEvent = new CloudEvent
            {
                Id = Guid.NewGuid().ToString(),
                Type = "com.example.sample",
                Source = new Uri("https://example.com"),
                DataContentType = MediaTypeNames.Application.Json,
                Time = DateTime.UtcNow,
                Data = new { cloudEventJson }
            };

            // Serialize the CloudEvent
            var cloudEventString = JsonConvert.SerializeObject(cloudEvent, new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
                TypeNameHandling = TypeNameHandling.Auto
            });

            log.LogInformation("CloudEvent: " + cloudEventString);



            }
        }
    }

    // Customize the model with your own desired properties
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
}
