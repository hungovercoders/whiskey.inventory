import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css'; // Import CSS file for styling

const WhiskeyDistilleries = () => {
  const [distilleries, setDistilleries] = useState([]);
  

  useEffect(() => {
    const fetchData = async () => {
      try {
       
        // Define the URL based on an environment variable or fallback to a default value
        const apiUrl = window._env_.API_URL || 'http://localhost:5240';
        console.log('Fetching data from ' + window._env_.API_URL);
        // Make a GET request using the URL
        const response = await axios.get(`${apiUrl}/distilleries`);
        setDistilleries(response.data);
        console.log('Data fetched:', response.data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="container">
      <h1>Whiskey Distilleries</h1>
      {distilleries.map((distillery, index) => (
        <div className="distillery" key={index}>
          <h2>{distillery.name}</h2>
          <p><strong>Country:</strong> {distillery.country}</p>
          <p><strong>Region:</strong> {distillery.region}</p>
          <p><strong>Website:</strong> <a href={distillery.website} target="_blank" rel="noopener noreferrer">{distillery.website}</a></p>
        </div>
      ))}
    </div>
  );
};

export default WhiskeyDistilleries;