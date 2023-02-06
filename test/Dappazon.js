const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("Dappazon", () => {

  let dappazon;
  let deployer, buyer;
  beforeEach( async () => {

    // Setup Accounts
    [deployer, buyer] = await ethers.getSigners()
    // console.log((deployer.address, buyer.address))

    // deploy contract
    const Dappazon = await ethers.getContractFactory("Dappazon")
    dappazon = await Dappazon.deploy()

  })

  describe("Deployment", () => {

    it("Sets the owner", async () => {
      expect(await dappazon.owner()).to.equal(deployer.address)
    })

    // it('has a name', async() => {
    //   const name = await dappazon.name()
    //   expect(name).to.equal("Dappazon")
    // })
  })

  describe("Listing", ()=> {
    let transaction

    const ID = 1

    beforeEach( async () => {

     transaction =  await dappazon.connect(deployer).list(
        ID,
        "Shoes",
        "Clothing",
        "IMAGE",
        1,
        4,
        5
      )

      await transaction.wait()
    
    })

      it("Returns item attributes", async () => {
          const item = await dappazon.items(ID)
          expect(item.id).to.equal(ID)
      })
  })

    
})
