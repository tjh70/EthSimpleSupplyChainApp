//Note I followed a tutorial for this code and do not own it

pragma solidity >=0.4.21 < 0.6.0;

contract SupplyChain{
    //define some values used by supply chain app
    uint32 public product_id = 0; //product id
    uint32 public participant_id = 0;  //participant id
    uint32 public owner_id = 0;  //ownership id

    //define structs
    //participant struct
    struct participant {
        string userName;
        string password;
        string participantType;
        address participantAddress;
    }

    //product struct
    struct product {
        string modelNumber;
        string partNumber;
        string serialNumber;
        address productOwner;
        uint32 cost;
        uint32 mfgTimeStamp;
    }

    //ownership struct
    struct ownership {
        uint32 productId;
        uint32 ownerId;
        uint32 traTimeStamp;
        address productOwner;
    }

    //mappings
    mapping(uint32 => product) public products;    //maps product id to product struct
    mapping(uint32 => ownership) public ownerships; //mapping of owner_id to wonerships
    mapping(uint32 => uint32[]) public productTrack; //ownershps by by product id / movement tracking of a product
    mapping(uint32 => participant) public participants; //map of participant ids to participants

    
}