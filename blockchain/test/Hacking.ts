import { ethers } from "hardhat";
import { expect } from 'chai';
import { HackingBadge, HackingBadge__factory } from "../typechain-types";


describe('Hacking NFT Badge', async () => {

  const CONTRACT_NAME = 'HackingBadge'
  const TOKEN_NAME = 'HackingBadge'
  const TOKEN_SYMBOL = 'HACKB'
  const BASE_URI = 'https://google.com/'

  //let wallets
  let factory: HackingBadge__factory;
  let hackingBadge: HackingBadge;


  before(async () => {
    const wallets = await ethers.getSigners()
    factory = await ethers.getContractFactory(CONTRACT_NAME)
  })

  beforeEach(async () => {
    hackingBadge = await factory.deploy(BASE_URI)
    await hackingBadge.deployed();
  })

  it('should by returns metadata contract info', async () => {
    expect(BASE_URI).to.be.equal(await hackingBadge.getBaseURI())
    expect(TOKEN_NAME).to.be.equal(await hackingBadge.name())
    expect(TOKEN_SYMBOL).to.be.equal(await hackingBadge.symbol())
  })

  it("NFT is minted successfully", async function() {
    const [account1] = await ethers.getSigners();

    expect(await hackingBadge.balanceOf(account1.address)).to.equal(0);
    
    const tokenURI = "https://gambakitties-metadata.herokuapp.com/metadata/1"
    const tx = await hackingBadge.connect(account1).safeMint(tokenURI);

    expect(await hackingBadge.balanceOf(account1.address)).to.equal(1);
})

})