import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { WalletsEntity } from './wallets.entity';
import { WalletsRepository } from './wallets.repository';
import { generateNewWallet } from './ethers.utils';

@Injectable()
export class WalletsService {
  constructor(
    @InjectRepository(WalletsRepository)
    private readonly walletRepository: WalletsRepository,
  ) {}

  public async createWallet(userId: string): Promise<WalletsEntity> {
    const newEtherWallet = generateNewWallet();

    const wallet = new WalletsEntity();
    wallet.userId = userId;
    wallet.address = newEtherWallet.address;
    wallet.mnemonic = newEtherWallet.mnemonic;
    wallet.privateKey = newEtherWallet.privateKey;
    wallet.publicKey = newEtherWallet.publicKey;

    const walletCreated = await this.walletRepository.save(wallet);
    return walletCreated;
  }

  public async findWalletByUserId(userId: string): Promise<WalletsEntity> {
    return await this.walletRepository.findOne({
      where: { userId, isActive: true },
    });
  }
}
