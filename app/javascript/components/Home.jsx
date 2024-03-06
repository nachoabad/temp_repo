import React, { useEffect, useState } from "react";

export default () => {
  const [companies, setCompanies] = useState([]);
  const [companyName, setCompanyName] = useState("");
  const [industry, setIndustry] = useState("");
  const [minEmployee, setMinEmployee] = useState("");
  const [minimumDealAmount, setMinimumDealAmount] = useState("");
  const [errorMessage, setErrorMessage] = useState(null);

  const fetchData = async () => {
    const url = `/api/v1/companies?name=${companyName}&industry=${industry}&min_employee=${minEmployee}&min_deal_amount=${minimumDealAmount}`;

    try {
      const response = await fetch(url);
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || 'Something went wrong');
      }

      setCompanies(data.companies);
      setErrorMessage(null);
    } catch (err) {
      setErrorMessage(err.message);
    }
  };

  useEffect(() => {
    const debouncedFetch = setTimeout(() => {
      fetchData();
    }, 300);
    return () => clearTimeout(debouncedFetch);
  }, [companyName, industry, minEmployee, minimumDealAmount]);

  const onChange = (e, setChange) => {
    const { value } = e.target;
    setChange(value);
  }

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>

          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="company-name" value={companyName} onChange={e => onChange(e, setCompanyName)} />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="industry" value={industry} onChange={e => onChange(e, setIndustry)} />
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input type="number" className="form-control" id="min-employee" value={minEmployee} onChange={e => onChange(e, setMinEmployee)} />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input type="number" className="form-control" id="min-amount" value={minimumDealAmount} onChange={e => onChange(e, setMinimumDealAmount)} />
          </div>

          {errorMessage && <p>Error message: {errorMessage}</p>}

          <table className="table">
            <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Industry</th>
                <th scope="col">Employee Count</th>
                <th scope="col">Total Deal Amount</th>
              </tr>
            </thead>
            <tbody>
              {companies.map((company) => (
                <tr key={company.id}>
                  <td>{company.name}</td>
                  <td>{company.industry}</td>
                  <td>{company.employee_count}</td>
                  <td>{company.deals_count}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
};
