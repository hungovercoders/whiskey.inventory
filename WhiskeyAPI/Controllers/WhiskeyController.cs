// using System.Net;
// using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WhiskeyAPI.Models;
// using Swashbuckle.AspNetCore.Annotations;
// using System;
// using System.Collections.Generic;
// using System.IO;
using System.Text.Json;
using Microsoft.Extensions.Caching.Memory;

namespace api.Controllers
{
    [Route("v1")] //this is the base route
    [ApiController]
    public class WhiskeyController : ControllerBase
    {
        private readonly IMemoryCache _cache;

        public WhiskeyController(IMemoryCache cache)
        {
            _cache = cache;
        }

        /// <summary>
        /// Gets list of distilleries
        /// </summary>
        /// <remarks>
        /// Sample request:
        /// 
        ///     GET api/v1/distilleries
        /// </remarks>
        /// <response code="200">Successfully returned distillers</response>
        /// <returns>Distilleries</returns>
        [Route("distilleries")]
        [HttpGet]
        public async Task<List<Distillery>> GetDistilleries(int pageNumber = 1, int pageSize = 10)
        {
            const string cacheKey = "distilleries";
            if (!_cache.TryGetValue(cacheKey, out List<Distillery> _distilleries))
            {
                Console.WriteLine("Retrieving data from storage...");
                string jsonString = await System.IO.File.ReadAllTextAsync("data/distilleries.json");
                _distilleries = JsonSerializer.Deserialize<List<Distillery>>(jsonString);

                _cache.Set(cacheKey, _distilleries, new MemoryCacheEntryOptions
                {
                    AbsoluteExpirationRelativeToNow = TimeSpan.FromDays(365)
                });
            }
            else
            {
                Console.WriteLine("Retrieving data from cache...");
            }
             int skip = (pageNumber - 1) * pageSize;
            return _distilleries.Skip(skip).Take(pageSize).ToList();
        }
    }
}