const main = async () => {
    // const unlockTime = "2605659962"; // unlock time must be > deployment time.
  
    const Edexa = await ethers.getContractFactory("edeXa");
    const edexa = await Edexa.deploy();
  
    await edexa.deployed()
    console.log("edeXa deployed to:", edexa.address);
  
  };
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });