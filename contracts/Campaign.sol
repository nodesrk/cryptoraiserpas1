// SPDX-License-Identifier: Unlicensed

pragma solidity >0.7.0 <=0.9.0;

contract CampaignFactory {
    address[] public deployedCampaigns;

    event campaignCreated(
        string title,
        uint requiredAmount,
        address indexed owner,
        address campaignAddress,
        string imgURI,
        uint indexed timestamp,
        string indexed category
        
    );

    function createCampaign(
        string memory campaignTitle, 
        uint requiredCampaignAmount, 
        string memory imgURI, 
        string memory category,
        string memory storyURI) public
    {

        Campaign newCampaign = new Campaign(
            campaignTitle, requiredCampaignAmount, imgURI, storyURI, msg.sender);
        

        deployedCampaigns.push(address(newCampaign));

        emit campaignCreated(
            campaignTitle, 
            requiredCampaignAmount, 
            msg.sender, 
            address(newCampaign),
            imgURI,
            block.timestamp,
            category
        );

    }
}


contract Campaign {
    string public title;
    uint public requiredAmount;
    string public image;
    string public story;
    address payable public owner;
    uint public receivedAmount;
    address payable public tax;
    uint public TaxAmount;


    event donated(address indexed donar, uint indexed amount, uint indexed timestamp);

    constructor(
        string memory campaignTitle, 
        uint requiredCampaignAmount, 
        string memory imgURI,
        string memory storyURI,
        address campaignOwner
    ) {
        title = campaignTitle;
        requiredAmount = requiredCampaignAmount;
        image = imgURI;
        story = storyURI;
        owner = payable(campaignOwner);
        tax=payable(0xdaB9381c51eAEcA154bD91600F6C1FCe94BCEA23);
    }

    function donate() public payable {
        require(requiredAmount > receivedAmount, "required amount fullfilled");
        tax.transfer(msg.value/100);
        TaxAmount= msg.value/100;
        owner.transfer(msg.value-TaxAmount);
        receivedAmount += msg.value;
        emit donated(msg.sender, msg.value, block.timestamp);
    }
}

