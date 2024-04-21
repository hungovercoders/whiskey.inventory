import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css'; // Import CSS file for styling

const WhiskeyDistilleries = () => {
  const [distilleries, setDistilleries] = useState([]);
  const [loading, setLoading] = useState(true); // Add loading state
  const [error, setError] = useState(null); // Add error state
  const [page, setPage] = useState(1); // Current page number
  const [pageSize, setPageSize] = useState(10); // Number of items per page
  const [hasMore, setHasMore] = useState(true); // Whether there are more pages

  useEffect(() => {
    const fetchData = async () => {
      try {
        const apiUrl = window._env_.API_URL || 'http://localhost:5240/api';
        const response = await axios.get(`${apiUrl}/distilleries?page=${page}&pageSize=${pageSize}`);
        setDistilleries(response.data);
        setHasMore(response.data.length === pageSize); // Check if there are more pages
        setLoading(false); // Set loading to false after data is fetched
      } catch (error) {
        console.error('Error fetching data:', error);
        setError('It seems our servers have drunk a little too much and they can\'t seem to find your whiskey!');
        setLoading(false); // Set loading to false in case of error
      }
    };

    fetchData();
  }, [page, pageSize]); // Add dependencies for page and pageSize

  const handlePrevPage = () => {
    if (page > 1) {
      setPage(page - 1);
    }
  };

  const handleNextPage = () => {
    if (hasMore) {
      setPage(page + 1);
    }
  };

  return (
    <div className="container">
      <h1>Whiskey Distilleries</h1>
      {loading ? ( // Check loading state
        <div className="loading">Please wait while we find you the finest whiskey distilleries...</div>
      ) : error ? ( // Check error state
        <div className="error">
          <p className="error-message">{error}</p>
          <p className="error-suggestion">Please refresh the page or try again later.</p>
        </div>
      ) : (
        <>
          <div className="pagination">
            <button onClick={handlePrevPage} disabled={page === 1}>Previous</button>
            <span>Page {page}</span>
            <button onClick={handleNextPage} disabled={!hasMore}>Next</button>
          </div>
          {distilleries.map((distillery, index) => {
            const website_url = new URL(distillery.website);
            website_url.searchParams.append('utm_source', 'hungovercoders');
            const wiki_url = new URL(distillery.wikipedia);
            wiki_url.searchParams.append('utm_source', 'hungovercoders');
            return (
              <div className="distillery" key={index}>
                <div className="text-content">
                  <h2>{distillery.name}</h2>
                  <p><strong>Country:</strong> {distillery.country}</p>
                  <p><strong>Region:</strong> {distillery.region}</p>
                  <p className="links">
                    <strong><a href={website_url.toString()} target="_blank" rel="noopener noreferrer">Website</a></strong>
                    |
                    <strong><a href={wiki_url.toString()} target="_blank" rel="noopener noreferrer">Wikipedia</a></strong>
                  </p>
                </div>
                <img src={`/flags/${distillery.country.toLowerCase()}.png`} alt={`${distillery.country} Flag`} className="distillery-image" />
              </div>
            );
          })}
          <div className="pagination">
            <button onClick={handlePrevPage} disabled={page === 1}>Previous</button>
            <span>Page {page}</span>
            <button onClick={handleNextPage} disabled={!hasMore}>Next</button>
          </div>
        </>
      )}
    </div>
  );
};

export default WhiskeyDistilleries;
