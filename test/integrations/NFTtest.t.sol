// SPDX-License-Identifer

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../../src/NFT.sol";
import {DeployNft} from "../../script/DeployNft.s.sol";

contract NFTtest is Test {
    DeployNft public deployNft;
    NFT public nft;
    address public CALI = makeAddr("Cali");
    string public constant SNIPERS =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployNft = new DeployNft();
        nft = deployNft.run();
    }

    function testNameIsCorrect() public view {
        string memory actualName = "Snipers";
        string memory expectedName = nft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testSymbolIsCorrect() public view {
        string memory actualSymbol = "SPR";
        string memory expectedSymbol = nft.symbol();
        assert(
            keccak256(abi.encodePacked(expectedSymbol)) ==
                keccak256(abi.encodePacked(actualSymbol))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(CALI);
        nft.mint(SNIPERS);

        assert(nft.balanceOf(CALI) == 1);
        assert(
            keccak256(abi.encodePacked(SNIPERS)) ==
                keccak256(abi.encodePacked(nft.tokenURI(0)))
        );
    }
}
