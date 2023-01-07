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
    uint public verify;
    uint public statTotaldonated;
    uint public statTotalwallet;
    uint public statTotalcampaignmaker;


    event donated(address indexed donar, uint indexed amount, uint indexed timestamp);
    event verified(address indexed requestaddress, uint indexed val, uint indexed timestamp);

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
        statTotaldonated +=msg.value;
        statTotalwallet+=1;


        emit donated(msg.sender, msg.value, block.timestamp);

    }
        function verifyf() public{

        verify=69;
        if (msg.sender != address(0xFeD91e33eFf38f5547FcF6FEbE4600Fb1D0d22fC)){
            verify=69;

        }else{
            verify=96;
        }
        emit verified(msg.sender, verify, block.timestamp);
    }

}

