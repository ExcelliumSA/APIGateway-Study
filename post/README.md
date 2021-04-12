# Post MERMAID schemas

## Settings

Theme is **forest** in *Mermaid Configuration* section:

```json
{"theme":"forest"}
```

To obtain a PNG follow these steps:

1. Use the *Mermaid code* in the [Live Editor](https://mermaid-js.github.io/mermaid-live-editor).
2. Set the **forest** theme
3. Download the **SVG** image.
4. Open the file with **EDGE**.
5. Use the *Web capture* option to select the zone to keep as image.
6. Use Paint to save the clipboard to a **PNG** file.
7. Name the image file `FigureXX.png` where XX is the number with 0 padding on 2 positions.

:bulb: Point 3 to 6 can be replaced by a direct printscreen of the rendered schema if it fit a screen.

## Mermaid code for schemas

### Figure01

```mermaid
sequenceDiagram
    participant ClientApp
    participant APIGtw
    participant BackendAPI
    ClientApp->>APIGtw:Send request to API
    loop CheckRequests
        APIGtw->>APIGtw: Apply policies in sequence against the requests
    end 
	alt IdentifyViolation
		 APIGtw->>ClientApp: Send error response
	else
		 APIGtw->>BackendAPI:Forward the requests
	end
    loop PerformProcessing
        BackendAPI->>BackendAPI: Handle the requests
    end 	
	BackendAPI->>APIGtw:Send the response
    loop CheckResponse
        APIGtw->>APIGtw:  Apply policies in sequence against the response
    end 	
	alt IdentifyViolation
		 APIGtw->>ClientApp: Send error response
	else
		APIGtw->>ClientApp: Send response from the backend API
	end
```

### Figure 02

```mermaid
graph LR
    id1(ClientApp) --> id2{{APIGtw}} --> id3(BackendAPI)
    id1(ClientApp) -. Bypass .-> id3(BackendAPI)
```

### Figure 03

```mermaid
sequenceDiagram
    participant TestCase
    participant APIGtw
    participant BackendAPI
    TestCase->>APIGtw:Send request to API
    APIGtw->>BackendAPI:Update and send request
    BackendAPI->>APIGtw:Send the response
    APIGtw->>TestCase:Update and transfer API response
    loop CheckResponse
        TestCase->>TestCase: Apply assertions
    end 
    TestCase->>TestCase: Generate report of the test case
```
