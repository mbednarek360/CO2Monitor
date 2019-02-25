# CO2Monitor
## Software to handle and serve data from an Li-840A

---

## **Serial Scraper:**

Written in Nim.  
Scrapes data from serial monitor on port `/dev/ttyusb0`.  
Will serve the data in a json format on port 5000.

---

Sequence Values:

**0:** celltemp  
**1:** cellpres  
**2:** co2  
**3:** co2abs  
**4:** h2o  
**5:** h2oabs  
**6:** h2odewpoint  
**7:** ivolt  
**8:** co2 (raw)  
**9:** co2ref (raw)  
**10:** h2o (raw)  
**11:** h2oref (raw)  