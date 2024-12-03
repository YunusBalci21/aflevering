from console import Console
from file import File
from string_utils import StringUtils

type Product {
    prodID: string
    shop: string
    category: string
    name: string
    price: double
}

type GetProductsRequest {
    shop?: string     
    category?: string 
}

type FileRequest {
    filename: string
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

service DBHandler {
    execution: sequential
    
    embed Console as console
    embed File as file
    embed StringUtils as stringUtils

    inputPort DBHandlerInput {
        Location: "socket://localhost:8000"
        Protocol: sodep
        Interfaces: DBInterface
    }

    define initDB {
        println@console("Initializing database...")();
        
        // Create directory if it doesn't exist
        mkdir@file("db")();
        
        // Check if products file exists
        exists@file("db/products.txt")(exists);
        if (!exists) {
            // Create initial products with more categories and stores
            f.filename = "db/products.txt";
            f.content = 
                // Netto products
                "P001;Netto;Mejeriprodukter;Arla Letmælk 1L;11.95\n" +
                "P002;Netto;Mejeriprodukter;Arla Yoghurt 1L;15.95\n" +
                "P003;Netto;Mejeriprodukter;Lurpak Smør 250g;22.95\n" +
                "P004;Netto;Grøntsager;Gulerødder 1kg;12.95\n" +
                "P005;Netto;Grøntsager;Kartofler 1kg;15.95\n" +
                "P006;Netto;Kød;Hakket Oksekød 400g;32.95\n" +
                "P007;Netto;Kød;Kyllingebryst 400g;35.95\n" +
                "P008;Netto;Brød;Rugbrød 1kg;18.95\n" +

                // Føtex products (slightly higher prices)
                "P101;Føtex;Mejeriprodukter;Arla Letmælk 1L;12.95\n" +
                "P102;Føtex;Mejeriprodukter;Arla Yoghurt 1L;16.95\n" +
                "P103;Føtex;Mejeriprodukter;Lurpak Smør 250g;23.95\n" +
                "P104;Føtex;Grøntsager;Gulerødder 1kg;13.95\n" +
                "P105;Føtex;Grøntsager;Kartofler 1kg;16.95\n" +
                "P106;Føtex;Kød;Hakket Oksekød 400g;34.95\n" +
                "P107;Føtex;Kød;Kyllingebryst 400g;37.95\n" +
                "P108;Føtex;Brød;Rugbrød 1kg;19.95\n" +

                // Bilka products (generally lowest prices)
                "P201;Bilka;Mejeriprodukter;Arla Letmælk 1L;11.50\n" +
                "P202;Bilka;Mejeriprodukter;Arla Yoghurt 1L;15.50\n" +
                "P203;Bilka;Mejeriprodukter;Lurpak Smør 250g;21.95\n" +
                "P204;Bilka;Grøntsager;Gulerødder 1kg;11.95\n" +
                "P205;Bilka;Grøntsager;Kartofler 1kg;14.95\n" +
                "P206;Bilka;Kød;Hakket Oksekød 400g;31.95\n" +
                "P207;Bilka;Kød;Kyllingebryst 400g;34.95\n" +
                "P208;Bilka;Brød;Rugbrød 1kg;17.95\n" +

                // Rema 1000 products
                "P301;Rema 1000;Mejeriprodukter;Arla Letmælk 1L;11.95\n" +
                "P302;Rema 1000;Mejeriprodukter;Arla Yoghurt 1L;15.95\n" +
                "P303;Rema 1000;Mejeriprodukter;Lurpak Smør 250g;22.95\n" +
                "P304;Rema 1000;Grøntsager;Gulerødder 1kg;12.95\n" +
                "P305;Rema 1000;Grøntsager;Kartofler 1kg;15.95\n" +
                "P306;Rema 1000;Kød;Hakket Oksekød 400g;32.95\n" +
                "P307;Rema 1000;Kød;Kyllingebryst 400g;35.95\n" +
                "P308;Rema 1000;Brød;Rugbrød 1kg;18.95\n" +

                // Lidl products (competitive prices)
                "P401;Lidl;Mejeriprodukter;Arla Letmælk 1L;11.75\n" +
                "P402;Lidl;Mejeriprodukter;Arla Yoghurt 1L;15.75\n" +
                "P403;Lidl;Mejeriprodukter;Lurpak Smør 250g;22.50\n" +
                "P404;Lidl;Grøntsager;Gulerødder 1kg;12.50\n" +
                "P405;Lidl;Grøntsager;Kartofler 1kg;15.50\n" +
                "P406;Lidl;Kød;Hakket Oksekød 400g;31.95\n" +
                "P407;Lidl;Kød;Kyllingebryst 400g;34.95\n" +
                "P408;Lidl;Brød;Rugbrød 1kg;17.95";
            writeFile@file(f)()
        }
    }

    init {
        println@console("Starting DB Handler...")();
        initDB;
        println@console("DB Handler initialized successfully")()
    }

    main {
        [ getProducts( request )( response ) {
            f.filename = "db/products.txt";
            readFile@file(f)(response.data);
            response.success = true;
            response.message = "Products retrieved successfully"
        }]
    }
}