# CO2Monitor
## Software to handle and serve data from an Li-840A

---

## **Serial Scraper:**

Written in Nim.  
Scrapes data from serial monitor on port `/dev/ttyusb0`.  
Caches values in given file.

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


---

## **HTTP Server:**

Written in Python.   
Hosts values in JSON format over a given port.

---

JSON Template:

```
{
    "celltemp": {{celltemp}}, 
    "cellpres": {{cellpres}},
    "co2": {{co2}},
    "co2abs": {{co2abs}},
    "h2o": {{h2o}},
    "h2oabs": {{h2oabs}},
    "h2odewpoint": {{h2odewpoint}},
    "ivolt": {{ivolt}},
    "raw": {
        "co2": {{co2raw}},
        "co2ref": {{co2ref}},
        "h2o": {{h2oraw}},
        "h2oref": {{h2oref}}
    }
}
```

---

## **Google Drive Integration:**

Written in shell using google-drive-ocamlfuse.   
Records values every second form server to file in csv format.   
Uploads spreadsheet to CO2 google drive folder.