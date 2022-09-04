import { ethers } from 'ethers';

export const generateNewWallet = () => {
  const wallet = ethers.Wallet.createRandom();

  return {
    address: wallet.address,
    mnemonic: wallet.mnemonic.phrase,
    privateKey: wallet.privateKey,
    publicKey: wallet.publicKey,
  };
};
