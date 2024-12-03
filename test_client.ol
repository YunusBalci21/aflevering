from console import Console
from string_utils import StringUtils

type GetProductsRequest {
    shop?: string     
    category?: string 
}

type DBResponse {
    success: bool
    message: string
    data: string
}

interface DBInterface {
    RequestResponse:
        getProducts( GetProductsRequest )( DBResponse )
}

service TestClient {
    embed Console as console
    embed StringUtils as stringUtils

    outputPort DBHandler {
        Location: "socket://localhost:8000"
        Protocol: sodep
        Interfaces: DBInterface
    }

    main {
        println@console("\n=== Shopping Price Comparison Test ===\n")();
        
        // Test getting all products
        println@console("Getting all products...\n")();
        
        // Create and send request
        getProductsReq = void;
        getProducts@DBHandler(getProductsReq)(response);

        println@console("Raw data received:")();
        println@console(response.data)();

        println@console("\nProducts in database:")();
        println@console("----------------------------------------\n")();

        // Split data into lines
        s = response.data;
        s.regex = "\n";
        split@stringUtils(s)(lines);

        for(i = 0, i < #lines.result, i++) {
            l = lines.result[i];
            l.regex = ";";
            split@stringUtils(l)(fields);

            println@console("Product ID: " + fields.result[0])();
            println@console("Store: " + fields.result[1])();
            println@console("Category: " + fields.result[2])();
            println@console("Product: " + fields.result[3])();
            println@console("Price: " + fields.result[4] + " DKK\n")();
            println@console("----------------------------------------\n")()
        };

        println@console("Test completed successfully!")()
    }
}