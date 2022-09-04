import { Injectable } from '@nestjs/common';
import { EthereumProvider } from './ethereum.provider';
import * as HackingBadge from '../../../../contract/HackingBadge.json';

@Injectable()
export class NFTProvider {
  private readonly contractAddress: string;
  private readonly abi = {};

  constructor(private readonly ethereumProvider: EthereumProvider) {
    this.contractAddress = process.env.CONTRACT_ADDRESS;
    this.abi = HackingBadge.abi;
  }

  public async mint(to: string, uri: string) {
    const minter = await this.ethereumProvider.loadWallet(
      process.env.PRIVATE_KEY,
    );

    const contract = await this.ethereumProvider.connectContract(
      this.contractAddress,
      this.abi,
    );

    const gasEstimated = await contract
      .connect(minter)
      .estimateGas.safeMint(to, uri);

    const tx = await contract.connect(minter).safeMint(to, uri, {
      gasLimit: gasEstimated,
    });
    const receipt = await tx.wait();
    const block = await this.ethereumProvider.provider.getBlock(
      receipt.blockNumber,
    );

    return {
      transactionHash: receipt.transactionHash,
      tokenId: receipt.events[0].args[2].toNumber(),
      timestamp: new Date(block.timestamp * 1000),
    };
  }
}
