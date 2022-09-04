import { Injectable, Logger } from '@nestjs/common';
import { Contract, ethers, Transaction, Wallet } from 'ethers';

@Injectable()
export class EthereumProvider {
  private readonly logger = new Logger(EthereumProvider.name);
  public readonly provider: ethers.providers.Provider;

  constructor() {
    this.logger.verbose(`Trying to connect to ${process.env.API_URL}`);

    this.provider = new ethers.providers.JsonRpcProvider(process.env.API_URL);

    this.provider
      .getNetwork()
      .then((network) => {
        this.logger.verbose(
          `Blockchain EVM ${network.name} connected id: ${network.chainId}`,
        );
      })
      .catch((error) => {
        this.logger.error(
          `Blockchain Connection error. Reason : ${error.message}`,
        );
      });
  }

  public async connectContract(address: string, abi: any): Promise<Contract> {
    const contract = new ethers.Contract(address, abi, this.provider);
    return contract;
  }

  public async loadWallet(privateKey: string): Promise<Wallet> {
    return new Wallet(privateKey, this.provider);
  }

  public async signTransaction(
    privateKey: string,
    transaction: Transaction,
  ): Promise<string> {
    const signer = new Wallet(privateKey, this.provider);
    const signedTransaction = await signer.signTransaction(transaction);
    return signedTransaction;
  }
}
