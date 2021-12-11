//I followed a tutorial for this code and do not own it

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

    //mappings (these should actually all be private i think but the tutorial has them like this)
    mapping(uint32 => product) private products;    //maps product id to product struct
    mapping(uint32 => ownership) public ownerships; //mapping of owner_id to wonerships
    mapping(uint32 => uint32[]) public productTrack; //ownershps by by product id / movement tracking of a producc
    mapping(uint32 => participant) private participants; //map of participant ids to participants 

    function addParticipant(string memory _username, string memory _password, string memory _participantType, address _participantAddress) public returns (uint32) {
        uint32 userID = participant_id++;
        participants[userID].userName=_username;
        participants[userID].password=_password;
        participants[userID].participantType=_participantType;
        participants[userID].participantAddress=_participantAddress;

        return userID;
    }

    function getParticipant(uint32 _participant_id) public view returns (string memory, address, string memory){
        return (participants[_participant_id].userName, participants[_participant_id].participantAddress, participants[_participant_id].participantType);
    }

    function addProduct(uint32 _ownerID, string memory _modelNumber, string memory _partNumber, string memory _serialNumber, address _productOwner, uint32 _cost) public returns (uint32) {
        if(keccak256(abi.encodePacked(participants[_ownerID].participantType)) == keccak256("Manufacturer")){
            uint32 productID = product_id++;

            products[productID].modelNumber = _modelNumber;
            products[productID].partNumber = _partNumber;
            products[productID].serialNumber = _serialNumber;
            products[productID].productOwner = _productOwner;
            products[productID].cost = _cost;
            products[productID].mfgTimeStamp = uint32(now);
            return productID;
        }
    }

    function getProduct(uint32 _product_id) public view returns (string memory, string memory, string memory, string memory, address, uint32, uint32) {
        return (products[_product_id].modelNumber, products[_product_id].modelNumber, products[_product_id].partNumber, products[_product_id].serialNumber, products[_product_id].productOwner, products[_product_id].cost, products[_product_id].mfgTimeStamp);
    }


    //     struct product {
    //     string modelNumber;
    //     string partNumber;
    //     string serialNumber;
    //     address productOwner;
    //     uint32 cost;
    //     uint32 mfgTimeStamp;
    // }
}